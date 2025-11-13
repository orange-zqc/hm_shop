import 'package:flutter/material.dart'; // 这个导入已经包含了WidgetsFlutterBinding
import 'package:hmshop/routes/index.dart';
import 'package:flutter/services.dart';

void main() {  
  // 设置状态栏颜色为灰色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey.withOpacity(0.01),
    statusBarIconBrightness: Brightness.dark,
  )); 
  runApp(getRouteWidget());
}
