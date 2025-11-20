import 'package:flutter/material.dart';
import 'package:hmshop/api/Search.dart';
import 'package:hmshop/viewmodels/VedioBean.dart';
import 'package:hmshop/widget/Home/SearchDetail.dart';
import 'package:hmshop/widget/Live/PlayDetail.dart';

class ToSearch extends StatefulWidget {
  const ToSearch({super.key});

  @override
  State<ToSearch> createState() => _ToSearchState();
}

class _ToSearchState extends State<ToSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();


  //存储获取的视频列表
  List<SearchDetailBean> videoList = [];



  GetMovieList() async {
    //根据文本获取视频列表
    videoList = await getSearchDetailApi(_searchController.text.trim());
    // 刷新界面
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 监听搜索框文本变化
    _searchController.addListener(() {
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          children: [
            // 搜索框
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  // 搜索图标
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                  ),
                  // 搜索输入框
                  Expanded(
                    child: TextField(
                      controller: _searchController, // 搜索框控制器
                      focusNode: _searchFocusNode, // 搜索框焦点节点
                      decoration: const InputDecoration(
                        hintText: '请输入搜索关键词...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => (
                        GetMovieList(),
                      ),
                    ),
                  ),
                  // 清除按钮
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey[600]),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      }, 
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 搜索按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: GetMovieList,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  '搜索',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
          Container(
            child: Text("共找到${videoList.length}部电影"),
          ),
          ListView.builder(
             shrinkWrap: true, // 列表高度自适应
             physics: NeverScrollableScrollPhysics(), // 禁止滚动
             itemCount: videoList.length,
             itemBuilder: (context, index) { // index 从0开始
               return GestureDetector(
                 onTap: () {
                  // 点击电影项时的操作
                  // 导航到电影详情页面
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayDetail(vedioId: videoList[index].id)));  
                 },
                 child: SearchDetail(searchItem: videoList[index]),
               );
             },

           ),

          ],
        ),
      )
    )
  );
  }

  
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();

  }
}