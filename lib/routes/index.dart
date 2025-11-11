// 1. 导入Flutter框架
import 'package:flutter/material.dart';
import 'package:hmshop/pages/Login/index.dart';
import 'package:hmshop/pages/Main/index.dart';

Widget getRouteWidget() {
  return MaterialApp(
    initialRoute: '/',
    routes: getRootRoutes(),

  );
}

// 2. 定义路由表
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    // 1. 首页路由
    '/': (context) => const MainPage(),


    // 2. 登录页路由
    '/login': (context) => const LoginPage(),

  };
}

