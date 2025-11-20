import 'package:flutter/foundation.dart';

class VedioBean{
  String id=""; //影片的id:vod_id
  String name=""; //影片的名字: vod_name
  String type=""; //影片的类型: vod_class
  String area=""; //影片的区域: vod_area
  String actor=""; //影片的演员: vod_actor
  String content=""; //影片的简介: vod_content  
  String imageUrl=""; //影片的图片地址: vod_pic
  String duration="" ?? "0"; //影片的时长: vod_duration,如果为空,则默认0
  // 构造函数
  VedioBean({
    required this.id,
    required this.name,
    required this.type,
    required this.area,
    required this.actor,
    required this.content,
    required this.imageUrl,
    required this.duration,
  });

  // 从JSON创建实例的工厂方法
  factory VedioBean.fromJson(Map<String, dynamic> json) {
    return VedioBean(
      id: json["vod_id"].toString(),
      name: json["vod_name"].toString(),
      type: json["vod_class"].toString(),
      area: json["vod_area"].toString(),
      actor: json["vod_actor"].toString(),
      content: json["vod_content"].toString(),
      imageUrl: json["vod_pic"].toString(),
      duration: json["vod_duration"]?.toString() ?? "0",
    );
  }

}


// 视频详情
class VideoDetailBean{
  String year=""; //影片的年份: vod_year
  String name=""; //影片的名字: vod_name
  String type=""; //影片的类型: vod_class
  String area=""; //影片的区域: vod_area
  String actor=""; //影片的演员: vod_actor
  String content=""; //影片的简介: vod_content  
  String playUrl=""; //影片的播放地址: vod_playurl
  String duration="" ?? "0"; //影片的时长: vod_duration,如果为空,则默认0
  // 构造函数
  VideoDetailBean({
    required this.year,
    required this.name,
    required this.type,
    required this.area,
    required this.actor,
    required this.content,
    required this.playUrl,
    required this.duration,
  });

  // 从JSON创建实例的工厂方法
  factory VideoDetailBean.fromJson(Map<String, dynamic> json) {
    return VideoDetailBean(
      year: json["vod_year"].toString(),
      name: json["vod_name"].toString(),
      type: json["vod_class"].toString(),
      area: json["vod_area"].toString(),
      actor: json["vod_actor"].toString(),
      content: json["vod_content"].toString(),
      playUrl: json["vod_play_url"].toString(),
      duration: json["vod_duration"]?.toString() ?? "0",
    );
  }

}






// 视频详情
class SearchDetailBean{
  String img=""; //影片的图片地址: vod_pic
  String id=""; //影片的id:vod_id
  String year=""; //影片的年份: vod_year
  String name=""; //影片的名字: vod_name
  String type=""; //影片的类型: vod_class
  String area=""; //影片的区域: vod_area
  String actor=""; //影片的演员: vod_actor
  String director=""; //影片的导演: vod_director
  String content=""; //影片的简介: vod_content  
  String duration="" ?? "0"; //影片的时长: vod_duration,如果为空,则默认0
  // 构造函数
  SearchDetailBean({
    required this.id,
    required this.year,
    required this.name,
    required this.type,
    required this.area,
    required this.director,
    required this.actor,
    required this.content,
    required this.duration,
    required this.img,
  });

  // 从JSON创建实例的工厂方法
  factory SearchDetailBean.fromJson(Map<String, dynamic> json) {
    return SearchDetailBean(
      img: json["vod_pic"].toString(),
      id: json["vod_id"].toString(),
      director: json["vod_director"].toString(),
      year: json["vod_year"].toString(),
      name: json["vod_name"].toString(),
      type: json["vod_class"].toString(),
      area: json["vod_area"].toString(),
      actor: json["vod_actor"].toString(),
      content: json["vod_content"].toString(),
      duration: json["vod_duration"]?.toString() ?? "0",
    );
  }

}



