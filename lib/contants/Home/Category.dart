import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  // 回调函数，用于通知父组件切换视图
  final Function(int) onCategoryTap;
  
  const Category({super.key, required this.onCategoryTap});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // 顶部分类栏分类名称列表
  final List<String> categories = ['推荐','Netflix','短剧','电影','院线上新','剧集','韩剧','动漫','综艺记录','福利'];
  // 顶部分类栏索引
  int _currentCategoryIndex = 0;
  
  // 只使用ScrollController来控制滚动
  late ScrollController _tabScrollController;
  
  // 用于存储每个tab的位置信息，以便点击时滚动到正确位置
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _tabScrollController = ScrollController();
    // 为每个分类项创建一个GlobalKey
    for (int i = 0; i < categories.length; i++) {
      _tabKeys.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.01),
      padding: EdgeInsets.only(top: 1, bottom: 3, left: 0),
      height: 45,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _tabScrollController,
        child: Row(        
          children: categories.asMap().entries.map((entry) {
            final int index = entry.key;
            final String category = entry.value;
            final bool isSelected = index == _currentCategoryIndex;
            
            return InkWell(
              key: _tabKeys[index],
              onTap: () {
                // 直接更新状态，避免动画冲突
                setState(() {
                  _currentCategoryIndex = index;
                });
                
                // 使用ensureVisible确保选中的项可见
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_tabKeys[index].currentContext != null) {
                    Scrollable.ensureVisible(
                      _tabKeys[index].currentContext!,
                      alignment: 0.5,
                      duration: Duration.zero, // 无动画滚动避免抖动
                    );
                  }
                });
                
                // 调用回调函数通知父组件切换视图
                // 直接传递分类索引，由父组件处理视图映射
                widget.onCategoryTap(index);
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(8, 7, 12, 7),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.pink[200] : Colors.black,
                        fontSize: isSelected ? 13 : 12,
                        // 选中时加粗
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected) 
                      Container(
                        height: 3.0,
                        //设置固定指示器宽度
                        width: 22, // 大致根据文字长度设置指示器宽度
                        color: Colors.pink[200],
                        margin: EdgeInsets.only(top: 5),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}