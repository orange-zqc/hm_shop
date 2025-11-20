

import 'package:flutter/material.dart';

class Discoveryhome extends StatefulWidget {
  const Discoveryhome({super.key});

  @override
  State<Discoveryhome> createState() => _DiscoveryhomeState();
}

class _DiscoveryhomeState extends State<Discoveryhome> {
  // 模拟分类数据
  final List<String> _categories = [
    '全部', '动作', '喜剧', '科幻', '爱情', '悬疑', '恐怖', '纪录片'
  ];
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset("lib/assets/轮播1.jpg", fit: BoxFit.cover),
          ),
          
          // 顶部导航栏
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: () {}, 
                    child: Text('上映表', style: TextStyle(fontSize: 20, color: Colors.black))),
                  TextButton(onPressed: () {}, 
                    child: Text('Netflix', style: TextStyle(fontSize: 20, color: Colors.black))),
                  TextButton(onPressed: () {}, 
                    child: Text('专题', style: TextStyle(fontSize: 20, color: Colors.black))),
                  TextButton(onPressed: () {}, 
                    child: Text('排行榜', style: TextStyle(fontSize: 20, color: Colors.black))),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}