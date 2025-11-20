import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hmshop/api/Play.dart';
import 'package:hmshop/viewmodels/VedioBean.dart';
import 'package:video_player/video_player.dart';

class PlayDetail extends StatefulWidget {
  const PlayDetail({super.key, required this.vedioId});
  // 视频id
  final String vedioId;


  @override
  State<PlayDetail> createState() => _PlayDetailState();
}

class _PlayDetailState extends State<PlayDetail> {
  // 将控制器改为可空类型
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  //未选中
  bool _isSelected = false;


  //接收视频数据
  List<VideoDetailBean> _videoDetail = []; //视频详情数据
  
  //当前影片的url列表
  List<String> _playUrls = [];
  //存储url列表
  List<String> PlayUrls = [];

  // 当前选中的播放线路索引
  int _selectedSourceIndex = 0;
  // 当前选中的集数索引
  int _selectedEpisodeIndex = 0;

  //播放片源的List
  final List<String> _playSources = [
    '原画',
    '蓝光',
    '4K',
    '720P',
    '540P',
    '360P',
    '自动',
  ];





  _getVedioDetail() async {
    _videoDetail = await getVedioDetailApi(widget.vedioId);
    if (_videoDetail.isNotEmpty) {
      // 提取播放地址
      String? playUrl = _videoDetail[0].playUrl;
      if (playUrl != null) {
        _playUrls = [playUrl]; // 存储完整的播放地址字符串
      }
      _extractVideoUrls();
            // 初始化视频播放器
      _initializeVideoPlayer();
    }
    setState(() {});
  }

  //分割url列表
      // 从格式化的播放地址字符串中提取视频URL
  void _extractVideoUrls() {
    print('_extractVideoUrls 开始执行,_playUrls初始长度: ${_playUrls.length}');
    PlayUrls.clear();
    try {
      // 遍历_playUrls中的每个元素
      for (var url in _playUrls) {
        if (url.contains('\$\$\$')) {
          // 移除$$$前缀部分
          List<String> parts = url.split('\$\$\$');
          print('parts: $parts');
          if (parts.length > 1) {
            // 按#分割获取每个集数的信息
            List<String> episodes = parts[1].split('#');
            print('episodes: $episodes');
            for (var episode in episodes) {
              // 按$分割获取标题和URL
              if (episode.contains('\$')) {
                List<String> episodeParts = episode.split('\$');
                if (episodeParts.length > 1) {
                  // 添加实际的视频URL
                  String videoUrl = episodeParts[1];
                  PlayUrls.add(videoUrl);
                  print('提取到视频URL: $videoUrl');
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print('提取视频URL时出错: $e');
    }
    
    print('_extractVideoUrls 执行完毕,PlayUrls最终长度: ${PlayUrls.length}');
  }


  

  Future<void> _initializeVideoPlayer() async {
    try {
      if (PlayUrls.isNotEmpty) {
        String firstVideoUrl = PlayUrls.first;
        print('初始化视频播放器,使用URL: $firstVideoUrl');       
        // 使用networkUrl而不是network，这是较新的API
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(firstVideoUrl),
        );
        
        // 等待视频初始化完成
        await _videoPlayerController!.initialize();
        
        // 只有当初始化完成后才创建ChewieController
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            looping: false,
            aspectRatio: _videoPlayerController!.value.aspectRatio,
          );
        });
      } else {
        print('没有可用的视频URL进行播放');
      }
    } catch (e) {
      print('视频初始化失败: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    _getVedioDetail();

  }


  // 模拟相关视频数据
  final List<Map<String, String>> _relatedVideos = List.generate(20, (index) => {
    'title': '相关视频 ${index + 1}',
    'imageUrl': 'https://picsum.photos/300/200?random=$index',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoDetail.isEmpty && _chewieController == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // 视频播放器
              Container(
            width: MediaQuery.of(context).size.width,
            height: 270,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
            ),
            child: _chewieController != null ? 
              Chewie(controller: _chewieController!) : 
              Center(child: CircularProgressIndicator())
          ),
          
          // 视频下方的Row组件
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 平均分布按钮
                    TextButton(
                      onPressed: () {
                      }, 
                      child: Text(
                        '详情',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {

                      }, 
                      child: Text(
                        '评论',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          // 可滚动的GridView.builder
          Expanded(  
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // 三个文本元素紧密排列
                    Container(
                      width:  double.infinity,
                      height:70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 7,top: 10),
                      margin: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 视频名称
                          Text(
                            _videoDetail.isNotEmpty ? _videoDetail.first.name : "加载中...",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 0.7,
                            ),
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              height: 0.7,
                              leading: 0.1,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, 10),
                            child: TextButton(
                              onPressed: () {
                                //跳转到简介页
                              },
                              child: Text(
                                _videoDetail.isNotEmpty
                                  ? "${_videoDetail.first.year} / ${_videoDetail.first.area} / ${_videoDetail.first.type} / 简介>"
                                  : "加载中...",
                                
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  height: 0.7,
                                ),
                                strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  height: 0.7,
                                  leading: 0.1,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft, // 文本左对齐
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 按钮大小适应内容
                              ),
                            ),
                          ),
                          // 豆瓣评分
                          Transform.translate(
                            offset: Offset(0, 20),
                            child: Text(
                              "豆瓣: 9.2分✨",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                height: 0.7,
                              ),
                              strutStyle: StrutStyle(
                                forceStrutHeight: true,
                                height: 0.7,
                                leading: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.only(top: 1,bottom: 10),
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround, // 平均分布按钮
                      children: [
                        //当点击收藏按钮时，改变图标颜色为红色
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            
                            highlightColor: Colors.transparent,
                          ),
                          icon: Icon(Icons.favorite,size: 25,color: Colors.grey,),

                          isSelected: _isSelected,
                          selectedIcon: Icon(Icons.favorite,size: 25,color: Colors.red[300],), // 选中时的图标
                          onPressed: () {
                              // 收藏按钮点击跳出弹窗

                            setState(() {
                                _isSelected = !_isSelected;
                            });
                            showDialog(
                              context: context,
                              barrierDismissible: false, // 点击弹窗外部是否关闭弹窗
                              builder: (context) {
                                //1秒后关闭弹窗
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop();
                                });
                                return AlertDialog(
                                  insetPadding:EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  content: Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    child:  (_isSelected) ? Text("您已成功收藏该影片") : Text("取消收藏成功"),
                                  ),
                                );

                                
                              }
                            );
                          },
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            
                            highlightColor: Colors.transparent,
                          ),
                          icon: Icon(Icons.swipe_down,size: 25,),
                          onPressed: () {
                            // 播放按钮点击事件处理
                            print('点击了下载按钮');
                          },
                        ),
                        IconButton(
                          style: IconButton.styleFrom( // 这个是设置按钮的固定尺寸
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29), // 圆角半径
                            ),
                            alignment: Alignment.center, // 居中对齐
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            // splashColor 已移除，IconButton 不支持该参数
                            highlightColor: Colors.transparent,
                          ),
                          icon: Icon(Icons.share,size: 25,),
                          onPressed: () {
                            // 分享按钮点击事件处理
                            print('点击了分享按钮');
                          },
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // 圆角半径
                            ),
                            alignment: Alignment.center, // 居中对齐
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4), // 按钮尺寸设置
                            highlightColor: Colors.transparent,
                          ),
                          icon: Icon(Icons.live_tv_rounded,size: 25,),
                          onPressed: () {
                            // 直播按钮点击事件处理
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text("您已成功收藏该影片"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('关闭'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),  
                  ),
                  //播放线路文本
                  Container(
                    padding: EdgeInsets.only(left: 7,bottom: 7,top: 1,),
                    margin: EdgeInsets.only(bottom: 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      '播放线路',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 50, // 添加固定高度
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _playSources.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 3),                          
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                // 选中状态下高亮显示
                                if (_selectedSourceIndex == index) {
                                  return Colors.blue[200]!; // 选中时的高亮颜色
                                }
                                return Colors.transparent; // 未选中时透明
                              }),
                              splashFactory: NoSplash.splashFactory, // 禁用点击波纹效果
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 按钮大小适应内容
                            ),
                            onPressed: () {
                              // 点击事件处理
                              setState(() {
                                _selectedSourceIndex = index; // 更新选中的索引
                              });
                              print('点击了按钮 $index');
                            },
                            child: Text(
                              _playSources[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _selectedSourceIndex == index ? Colors.white : Colors.black, // 选中时文本为白色，未选中时为黑色
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //集数文本
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 7,top: 7,),
                    child: Text(
                      '集数',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 7, bottom: 0),
                    height: 46,
                    width: double.infinity, // 添加固定高度
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: PlayUrls.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), //和按钮的圆角保持一致
                              )),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                // 选中状态下高亮显示
                                if (_selectedEpisodeIndex == index) {
                                  return Colors.pink[200]!; // 选中时的高亮颜色
                                }
                                return Colors.grey[200]!; // 未选中时的背景色
                              }),
                              splashFactory: NoSplash.splashFactory, // 禁用点击波纹效果
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              // 点击事件处理
                              setState(() {
                                _selectedEpisodeIndex = index; // 更新选中的集数索引
                              });
                              print('点击了集数按钮 $index');
                            },
                            child:Text(
                                '第${index + 1}集',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedEpisodeIndex == index ? Colors.white : Colors.black,
                                ),
                              ),

                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "好片推荐"文本
                        Container(
                          padding: EdgeInsets.only(left: 7, top: 7, bottom: 0), // 进一步减小底部间距
                          child: Text(
                            '好片推荐',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // GridView部分
                        Container(
                          height: 1350, // 固定高度以适应SingleChildScrollView
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: GridView.builder(
                            padding: EdgeInsets.only(top: 7), // 增加顶部间距
                            shrinkWrap: true, // 允许GridView根据内容大小调整高度
                            physics: NeverScrollableScrollPhysics(), // 禁用自身滚动
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // 每行显示3个项目
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1 / 1.7, // 宽高比
                            ),
                            itemCount: _relatedVideos.length,
                            itemBuilder: (context, index) {
                        final video = _relatedVideos[index];
                        return GestureDetector(
                          onTap: () {
                            // 点击事件处理
                            print('点击了视频 ${index + 1}');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  // 视频缩略图
                                  Expanded(
                                    child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                      image: DecorationImage(
                                        image: NetworkImage(video['imageUrl']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // 视频标题
                                Padding(
                                  padding: EdgeInsets.only(top: 3),
                                  child: Center(
                                    child: Text(
                                    video['title']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    maxLines: 1, // 限制标题显示为2行
                                    overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        )
        ],
      ),
    );
}

  @override
  void dispose() {
    // 按照正确的顺序销毁控制器：先销毁依赖的控制器(chewie)，再销毁被依赖的控制器(video)
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }
}