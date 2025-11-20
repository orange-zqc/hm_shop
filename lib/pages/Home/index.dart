import 'package:flutter/material.dart';
import 'package:hmshop/widget/Home/Category.dart';
import 'package:hmshop/widget/Home/HomeSlider.dart';
import 'package:hmshop/widget/Home/MoreGrid.dart';
import 'package:hmshop/widget/Home/Search.dart';


class HomeView extends StatefulWidget {
  final Function(int) onCategoryTap;
  
  const HomeView({super.key, required this.onCategoryTap});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{

  
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
                Category(onCategoryTap: widget.onCategoryTap),
              ],
            ),
          ),
        ],
      ),
    );
  }


}