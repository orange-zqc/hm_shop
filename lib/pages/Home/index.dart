import 'package:flutter/material.dart';
import 'package:hmshop/contants/Home/Category.dart';
import 'package:hmshop/contants/Home/HomeSlider.dart';
import 'package:hmshop/contants/Home/MoreGrid.dart';
import 'package:hmshop/contants/Home/Search.dart';

class HomeView extends StatelessWidget {
  final Function(int) onCategoryTap;
  
  const HomeView({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主要内容区域 - 可以滚动
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // 轮播图在最底层，搜索框和分类栏将覆盖在上面
                HomeSlider(),
                // 轮播图下方的内容
                MoreGrid(),
              ],
            ),
          ),
          // 悬浮在顶部的搜索框和分类栏，覆盖在轮播图上
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Search(),
                Category(onCategoryTap: onCategoryTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}