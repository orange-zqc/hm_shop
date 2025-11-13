import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  // 轮播图图片列表
  final List<String> carouselImages = [
    'lib/assets/轮播1.jpg',
    'lib/assets/轮播2.jpg',
    'lib/assets/轮播3.jpg',
    'lib/assets/轮播4.jpg',
  ];
  // 当前轮播图索引
  int _currentCarouselPage = 0;



  @override
  Widget build(BuildContext context) {
    return Stack(     
                children: [
                  // 轮播图组件
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          // 更新当前轮播图索引
                          _currentCarouselPage = index;
                        });
                      },
                    ),
                    items: carouselImages.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // 轮播图指示器
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: List.generate(carouselImages.length, (index) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // 实现逻辑:如果当前轮播图索引与指示器索引相等,则为选中状态,设置为深粉色,否则设置为半透明白色
                            color: _currentCarouselPage == index
                                ? Colors.pink[200]
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
  }
}
