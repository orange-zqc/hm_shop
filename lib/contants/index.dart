//基础地址:https://jszyapi.com


class GlobalConstants {
  static const String BASE_URL = 'https://jszyapi.com'; //基础地址
  static const int TIMEOUT = 10; //超时时间10秒
  static const String SUCCESS_CODE = '1'; //成功状态码
}


class HttpConstants {
  static const String VIDEO_LIST = '/api.php/provide/vod/?ac=videolist'; //视频列表不带分类

  static const String VIDEO_DETAIL = '/api.php/provide/vod/?ac=videolist&ids='; //视频详情


  //搜索视频
  static const String SEARCH_VIDEO = '/api.php/provide/vod/?ac=videolist&wd='; //搜索视频
}

