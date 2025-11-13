import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmshop/widget/Mine/CollectionDetail.dart';
import 'package:hmshop/widget/Mine/DownLoadDeatil.dart';
import 'package:hmshop/widget/Mine/HistoryDetail.dart';
import 'package:hmshop/widget/Mine/SettingDetail.dart';

class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('lib/assets/MineBackGround.png', fit: BoxFit.cover,),             
          ),
          Positioned(
            top: 30,
            right: 1,
            child:  Row(
              // 主AxisAlignment.end 子元素从右向左排列
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ 
                  IconButton(
                    onPressed: () {
                      //点击TV投屏按钮
                      print('点击了设置');
                    }, 
                    icon: Icon(Icons.tv, size:25, color: Colors.black,),
                    padding: EdgeInsets.only(right: 1), 
                  ),
                  IconButton(
                    //点击设置按钮
                    onPressed: () {
                      Get.to(SettingDetail());
                    }, 
                    icon: Icon(Icons.settings, size:25, color: Colors.black,),
                    padding: EdgeInsets.only(right: 1),
                    constraints: BoxConstraints(),
                  ),

  
                ]
              ),
          ),
          // 灰色 Card
          Positioned(
            top: 221,
            left: 0,
            right: 1,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 收藏按钮
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(CollectionDetail());
                            print('点击了收藏');
                          }, 
                          icon: Icon(Icons.star, size:30, color: Colors.grey,),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '收藏',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // 历史记录按钮
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(Historydetail());
                            print('点击了历史记录');
                          }, 
                          icon: Icon(Icons.history, size:30, color: Colors.grey,),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '历史',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // 下载按钮
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(DownLoadDeatil());
                            print('点击了下载');
                          }, 
                          icon: Icon(Icons.file_download_outlined, size:30, color: Colors.grey,),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '下载',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // 分享按钮
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // 点击分享按钮
                            print('分享');
                          }, 
                          icon: Icon(Icons.switch_access_shortcut_rounded, size:30, color: Colors.grey,),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '分享',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 1,
            right: 400,
            child:IconButton(
                    onPressed: () {
                      print('点击了头像');
                  }, 
                  icon: Icon(Icons.account_circle, size:50, color: Colors.black,),
                  ),
            ),

          Positioned(
            top: 327,
            left: 1,
            right: 1,
            child: Card(
              elevation: 4, //阴影深度
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child:Container(
                padding: EdgeInsets.only(top:0,left: 10,right: 10),
                height: 300,
                width:double.infinity,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // 我的订单
                    ListTile(
                      //
                      contentPadding: EdgeInsets.zero,
                      //设置金币的icon
                      leading: Icon(Icons.monetization_on_outlined, size:30, color: Colors.grey,),
                      title: Text(
                        '我的金币',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size:20, color: Colors.grey),
                    ),
                    // 我的收藏
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.gamepad_outlined, size:30, color: Colors.grey,),
                      title: Text(
                        '我的游戏',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size:20, color: Colors.grey,),
                    ),
                    // 我的资产
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.wallet_travel_outlined, size:30, color: Colors.grey,),
                      title: Text(
                        '我的资产',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size:20, color: Colors.grey,),
                    ),
                    //反馈/求片
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.help_outline_outlined, size:30, color: Colors.grey,),
                      title: Text(
                        '帮助与反馈',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size:20, color: Colors.grey,),
                    ),
                    //关于我们
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.info_outlined, size:30, color: Colors.grey,),
                      title: Text(
                        '关于我们',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size:20, color: Colors.grey,),
                    ),

                    //
                  ],
                ),
                //我的资产
              ),

            ),
          ),

        ]

      )
    );
  }
}