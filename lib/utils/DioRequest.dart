//基于Dio进行二次封装
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hmshop/contants/index.dart';
class DioRequest{
  //属性
  final  _dio = Dio();

  //构造函数
  DioRequest(){
    //基础配置
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);

  }
  //拦截器函数
  void _addInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        
        // 在发送请求之前
        return handler.next(options); // 继续发送请求
      },
      onResponse: (response, handler) {
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          handler.next(response); // 继续处理响应
          return;
          // 成功状态码处理
        }

        // 在收到响应之前
        return handler.reject(DioException(requestOptions: response.requestOptions)); // 继续处理响应
      },
      onError: (DioError e, handler) {
        // 在发生错误之前做一些事情
        return handler.reject(e); // 继续处理错误
      },
    ));
  }

  Future<dynamic> get(String url,{Map<String,dynamic>? params}) async{
    return await _handleResponse(_dio.get(url,queryParameters: params));
  }

  //进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response> task) async{
    try{
      Response<dynamic> res = await task;
      
      // 检查响应数据
      if(res.data == null) {
        print('响应数据为null');
        return null;
      }
      
      // 处理字符串响应
      if(res.data is String) {
        String responseString = res.data;
        print('收到字符串响应: $responseString');
        
        // 先尝试解析JSON，不管字符串内容如何
        try {
          final decodedData = jsonDecode(responseString);
          print('JSON解析成功,数据类型: ${decodedData.runtimeType}');
          
          if(decodedData is Map<String,dynamic>) {
            // 检查是否是包含list字段的成功响应
            if(decodedData.containsKey("list")) {
              print('提取list字段数据');
              return decodedData["list"] ?? [];
            }
            // 如果有msg字段且包含"数据列表"，仍然尝试返回list字段
            if(decodedData.containsKey("msg") && decodedData["msg"] == "数据列表") {
              print('检测到msg为"数据列表",返回list字段');
              return decodedData["list"] ?? [];
            }
            return decodedData; // 返回整个Map
          }
          return decodedData; // 返回解码后的数据
        } catch (e) {
          print('JSON解析失败: $e');
          // 只有当纯文本"数据列表"且解析失败时才返回空列表
          if(responseString == "数据列表") {
            print('纯文本"数据列表",返回空列表');
            return [];
          }
          // 其他解析失败的情况返回空列表
          return [];
        }
      }
      
      // 处理Map响应
      if(res.data is Map<String,dynamic>) {
        final data = res.data as Map<String,dynamic>;
        print('收到Map响应,检查list字段');
        // 直接检查是否有list字段
        if(data.containsKey("list")) {
          return data["list"] ?? [];
        }
        return data; // 返回整个Map
      }
      
      // 返回其他类型的数据
      print('返回其他类型数据: ${res.data.runtimeType}');
      return res.data;
    }catch(e){
      print('请求处理错误: $e');
      // 返回null而不是抛出异常，让上层处理
      return null;
    }
  }

}

//单例对象
final  dioRequest = DioRequest();