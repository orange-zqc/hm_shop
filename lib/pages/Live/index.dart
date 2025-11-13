import 'package:flutter/material.dart';


class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
      // 放映厅图片列表
      final List<String> _liveImages = [
      'lib/assets/LiveImages/Dramon.png',
      'lib/assets/LiveImages/Dragon.png',
      'lib/assets/LiveImages/Naruto.png',
      'lib/assets/LiveImages/爱情公寓.jpg',
       'lib/assets/LiveImages/Dramon.png',
      'lib/assets/LiveImages/Dragon.png',
      'lib/assets/LiveImages/Naruto.png',
      'lib/assets/LiveImages/爱情公寓.jpg',
      
    ];

      // 放映厅名称列表
      final List<String> _liveNames = [
        '哆啦a梦',
        '七龙珠',
        '火影忍者',
        '爱情公寓',
        '哆啦a梦',
        '七龙珠',
        '火影忍者',
        '爱情公寓',
      ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('开端放映厅🎥')),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: _liveImages.length,
        itemBuilder: (context, index) {
          return  
            Container(
              padding: EdgeInsets.only(left: 4,right: 4), //margin的功能是设置Container与Grid之间的间距
              height: 130,
              child: GestureDetector(
                // 点击事件，跳转到详情页
                onTap: (){
                     //将放映厅名称传递到详情页
                     
                },
                child: Column(    
                children: [
                //将图片裁剪成与Card的圆角一致
                  ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(_liveImages[index], height: 130,width: double.infinity,fit: BoxFit.cover,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.play_arrow,color: Colors.green,),
                      Text('${_liveNames[index]}',style: TextStyle(fontSize: 16,color: Colors.black),),
                    ],
                  ),
                  Text('正在放映: ${_liveNames[index]} 第594集',style: TextStyle(fontSize: 13,color: Colors.green),),
              ],
            ),
           )
          );
        },
      ),
    );
  }
}