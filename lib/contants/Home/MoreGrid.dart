import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MoreGrid extends StatefulWidget {
  const MoreGrid({super.key});

  @override
  State<MoreGrid> createState() => _MoreGridState();
}

class _MoreGridState extends State<MoreGrid> {

    // 存放所有文件（包含lib/assets目录下的所有图片资源）
    final List<String> _gridImages = [
      'lib/assets/2001太空漫游.jpg',
      'lib/assets/7号房的礼物.jpg',
      'lib/assets/一一.jpg',
      'lib/assets/一个叫欧维的男人决定去死.jpg',
      'lib/assets/七宗罪.jpg',
      'lib/assets/七武士.jpg',
      'lib/assets/三傻大闹宝莱坞.jpg',
      'lib/assets/三块广告牌.jpg',
      'lib/assets/上帝之城.jpg',
      'lib/assets/东京教父.jpg',
      'lib/assets/东邪西毒.jpg',
      'lib/assets/两杆大烟枪.jpg',
      'lib/assets/九品芝麻官.jpg',
      'lib/assets/乱世佳人.jpg',
      'lib/assets/人工智能.jpg',
      'lib/assets/低俗小说.jpg',
      'lib/assets/何以为家.jpg',
      'lib/assets/你的名字.jpg',
      'lib/assets/你看起来好像很好吃.jpg',
      'lib/assets/侧耳倾听.jpg',
      'lib/assets/借东西的小人阿莉埃蒂.jpg',
      'lib/assets/一个叫欧维的男人决定去死.jpg'
    ];


    @override
    void initState() {
      super.initState();
    }
    
    /// 从文件路径中提取文件名（不包含扩展名）
    String _getFileNameFromPath(String path) {
      // 获取文件名部分（不包含路径）
      String fileName = path.split('/').last;
      // 去掉扩展名
      if (fileName.contains('.')) {
        return fileName.substring(0, fileName.lastIndexOf('.'));
      }
      return fileName;
    }



    // 随机提示语
    final List<String> _bottomTips = [
    '🎊 到底啦，休息一下吧！',
    '🎁 惊喜即将到来',
    "🎉哎呀，被你刷到底啦！",
    "🌍恭喜你发现世界的尽头！",
    "📏别刷了，再刷也不会长高的~ ",
    "🧠你已经到达知识的边界 ",
    ];

    // 获取随机提示语方法
    String _getRandomTip() {
      return _bottomTips[Random().nextInt(_bottomTips.length)];
    }


  @override
  Widget build(BuildContext context) {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 滚动文字
                      Container(
                        height: 23,
                        padding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 2),
                        child: Marquee(
                          text: '欢迎大家使用开端影视,如果喜欢请给个好评。请务必使用正版软件，避免使用盗版软件，否则后果自负！', 
                          style: TextStyle(color: Colors.black, fontSize: 10),
                          pauseAfterRound: Duration(seconds: 1),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      // 内容区块
                      _buildContentSection('推荐内容'),
                      _buildContentSection('热门电影'),
                      _buildContentSection('最新剧集'),
                      _buildContentSection('精选动漫'),
                      _buildContentSection('综艺推荐'),
                      // 底部随机提示语
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        alignment: Alignment.center,
                        child: Text(

                          // 随机提示语
                          _getRandomTip(),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 底部间距，确保内容不被底部固定分类栏遮挡
                      SizedBox(height: 60)
                    ],
                  );
  }

    /// 内容区域构建方法
  /// 参数：title - 内容区块标题
  Widget _buildContentSection(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 2), //fromLTRB(left, top, right, bottom)
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 区块标题
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // 内容网格视图 - 通过padding属性减少与标题的间距
          GridView.builder(
            padding: EdgeInsets.only(top: 3), // 设置区块标题和网格之间的间距
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 每行3个项目
              crossAxisSpacing: 8, // 列间距
              mainAxisSpacing: 8, // 行间距
              childAspectRatio: 0.6, // 项目纵横比（宽度/高度）
            ),
            itemCount: _gridImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: [
                    // 内容图片
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                          image: DecorationImage(
                            image: AssetImage(_gridImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // 内容标题
                    Padding(
                      padding: EdgeInsets.all(4), // 内容标题内边距
                      child: Text(
                        // 从图片路径中提取文件名（不包含扩展名）
                        _getFileNameFromPath(_gridImages[index]),
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),     
    );
  }
}
