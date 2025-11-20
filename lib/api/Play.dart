//封装视频列表和详情接口
import 'package:hmshop/contants/index.dart';
import 'package:hmshop/utils/DioRequest.dart';
import 'package:hmshop/viewmodels/VedioBean.dart';

// 获取视频列表或单个视频详情
// 如果传入vod_id，则获取单个视频详情；否则获取视频列表
Future<List<VideoDetailBean>> getVedioDetailApi(String vedioId) async {
  // 根据是否有vod_id选择API路径
  String apiPath;
  if (vedioId != null && vedioId.isNotEmpty) {
    apiPath = '${HttpConstants.VIDEO_DETAIL}$vedioId';
    print('获取单个视频详情,vod_id: $vedioId');
  } else {
    apiPath = HttpConstants.VIDEO_LIST;
    print('获取视频列表');
  }
  
  // 获取API响应数据
  final responseData = await dioRequest.get(apiPath);
  
  print('API响应数据类型: ${responseData?.runtimeType}');
  print('API响应数据: $responseData');
  
  // 空值检查
  if (responseData == null) {
    print('API返回数据为空');
    return [];
  }
  // 类型安全转换 - 确保我们得到一个列表
  List<dynamic> dataList;
  if (responseData is List) {
    dataList = responseData;
  } else if (responseData is Map<String, dynamic>) {
    // 处理可能从Map中提取的list字段
    if (responseData.containsKey('list')) {
      final listField = responseData['list'];
      dataList = listField is List ? listField : [];
    } else {
      // 单个视频详情可能直接返回Map，包装成列表
      dataList = [responseData];
    }
  } else {
    dataList = [];
  }
  
  print('处理后的数据列表长度: ${dataList.length}');
  
  if (dataList.isEmpty) {
    print('数据列表为空，返回空列表');
    return [];
  }
  
  // 将数据列表转换为VideoDetailBean对象列表
  try {
    return dataList.map((item) => VideoDetailBean.fromJson(item)).toList();
  } catch (e) {
    print('数据转换失败: $e');
    return [];
  }
}


  