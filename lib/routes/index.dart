// 1. 导入Flutter框架
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hmshop/pages/Main/index.dart';

// 1. 获取路由组件
Widget getRouteWidget() {
  return GetMaterialApp(
    initialRoute: '/',
    routes: getRootRoutes(),
  );
}

// 2. 定义路由表
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    // 1. 首页路由
    '/': (context) => const MainPage(),
  };
}

