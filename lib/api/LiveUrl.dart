
import 'package:get/get_utils/get_utils.dart';

// 视频模型
class VideoInfo {
  final String id;
  final String title;
  final String url;
  final String? thumbnailUrl;
  final String? description;

  VideoInfo({
    required this.id,
    required this.title,
    required this.url,
    this.thumbnailUrl,
    this.description,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
    };
  }
}

// 视频获取API服务
class VideoApiService {
  // 模拟视频数据
  final List<VideoInfo> _mockVideos = [
    VideoInfo(
      id: '1',
      title: '示例视频 1',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnailUrl: null,
      description: '这是第一个示例视频',
    ),
    VideoInfo(
      id: '2',
      title: '示例视频 2',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      thumbnailUrl: null,
      description: '这是第二个示例视频',
    ),
  ];

  // 获取所有视频
  Future<List<VideoInfo>> getAllVideos() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVideos;
  }

  // 根据ID获取单个视频
  Future<VideoInfo?> getVideoById(String id) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockVideos.firstWhereOrNull((video) => video.id == id);
  }

  // 获取推荐视频列表
  Future<List<VideoInfo>> getRecommendedVideos() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVideos;
  }
}

// 提供全局单例实例
final videoApiService = VideoApiService();


//返回业务侧要的数据
