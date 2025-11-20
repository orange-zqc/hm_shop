//封装一个api 用于返回业务侧要的数据结构
import 'package:hmshop/contants/index.dart';
import 'package:hmshop/utils/DioRequest.dart';
import 'package:hmshop/viewmodels/VedioBean.dart';

Future<List<VedioBean>> getVedioListApi() async {
  try {
    // 获取API响应数据
    final responseData = await dioRequest.get(HttpConstants.VIDEO_LIST);
    
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
    } else if (responseData is Map<String, dynamic> && responseData.containsKey('list')) {
      // 处理可能从Map中提取的list字段
      final listField = responseData['list'];
      dataList = listField is List ? listField : [];
    } else {
      dataList = [];
    }
    
    print('处理后的数据列表长度: ${dataList.length}');
    
    if (dataList.isEmpty) {
      print('数据列表为空，返回空列表');
      return [];
    }
    




    
    // 使用try-catch包装整个map操作
    try {
      return dataList.map((item) {
        // 确保item是Map类型
        if (item is Map<String, dynamic>) {
          try {
            // 尝试直接从JSON创建VedioBean
            return VedioBean.fromJson(item);
          } catch (e) {
            print('解析单个视频数据失败: $e, 数据: $item');
            // 返回默认VedioBean对象，提供所有必需的参数
            return VedioBean(
              id: '',
              name: '',
              type: '',
              area: '',
              actor: '',
              content: '',
              imageUrl: '',
              duration: '0',
            );
          }
        } else {
          print('无效的数据项类型: ${item.runtimeType}, 值: $item');
          // 返回默认VedioBean对象
          return VedioBean(
            id: '',
            name: '',
            type: '',
            area: '',
            actor: '',
            content: '',
            imageUrl: '',
            duration: '0',
          );
        }
      }).toList();
    } catch (mapError) {
      print('处理数据列表时发生错误: $mapError');
      return [];
    }
  } catch (e) {
    print('获取视频列表失败: $e');
    return [];
  }
}