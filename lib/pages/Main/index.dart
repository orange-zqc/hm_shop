import 'package:flutter/material.dart';
import 'package:hmshop/contants/Home/Category.dart';
import 'package:hmshop/contants/Home/Search.dart';
import 'package:hmshop/pages/Discovery/index.dart';
import 'package:hmshop/pages/Game/index.dart';
import 'package:hmshop/pages/Home/index.dart';
import 'package:hmshop/pages/Live/index.dart';
import 'package:hmshop/pages/Mine/index.dart';
import 'package:hmshop/pages/TopNavigationBar/Anime.dart';
import 'package:hmshop/pages/TopNavigationBar/Benefits.dart';
import 'package:hmshop/pages/TopNavigationBar/KoreanDrama.dart';
import 'package:hmshop/pages/TopNavigationBar/Movie.dart';
import 'package:hmshop/pages/TopNavigationBar/Netflix.dart';
import 'package:hmshop/pages/TopNavigationBar/NewlyLaunched.dart';
import 'package:hmshop/pages/TopNavigationBar/Playlet.dart';
import 'package:hmshop/pages/TopNavigationBar/TvDrama.dart';
import 'package:hmshop/pages/TopNavigationBar/VarietyShowRecord.dart';
import 'package:hmshop/pages/WatchPage/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  // 底部导航栏的索引
  int _bottomIndex = 0;
  // 底部导航栏控制器
  late TabController _bottomTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化底部导航栏控制器
    _bottomTabController = TabController(vsync: this, length: 6);


  }


  //顶部导航栏的视图跳转列表
  List<Widget> _getTopNavViews(){
    return [
      Container(child: NetflixView()), //  Netflix
      Container(child: PlayletView()), //  短剧
      Container(child: MovieView()), //  电影
      Container(child: NewlyLaunchedView()), //  院线上新
      Container(child: TvDramaView()), //  剧集
      Container(child: KoreanDramaView()), //  韩剧
      Container(child: AnimeView()), //  动漫
      Container(child: VarietyShowRecordView()), //  综艺记录
      Container(child: BenefitsView()), //  福利
    ];
  }




  // 底部导航栏跳转视图的列表
  List<Widget> _getChildren() {
    return [
      // 首页，传递空的onCategoryTap回调，因为分类导航栏现在在MainPage中
      Container(child: HomeView(onCategoryTap: (_) {})),
      // 发现
      Container(child: DiscoveryView()),
      // 看啥片
      Container(child: WatchView()),
      // 直播
      Container(child: LiveView()),
      // 游戏
      Container(child: GameView()),
      // 我的
      Container(child: MineView()),      
    ];
  }
  
  // 判断是否显示搜索框和分类导航栏
  bool _shouldShowTopBar() {
    // 只在首页和顶部导航视图中显示（索引0或>=6）
    return _bottomIndex == 0 || _bottomIndex >= 6;
  }

  // 底部导航栏的图标
  List<BottomNavigationBarItem> _getBottomItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: '发现',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_arrow),
        label: '看啥片',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.live_tv),
        label: '直播',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.gamepad),
        label: '游戏',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '我的',
      ),
    ];
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 主体内容区域
      body:  Stack(
          children: [
          // 主要内容区域 - 填充整个空间
            Container(
            width: double.infinity,
            height: double.infinity,
            child: IndexedStack(
              // 索引栈，根据索引显示对应的页面
              index: _bottomIndex,
              // 索引栈的子元素
              children: [..._getChildren(),..._getTopNavViews()], // 底部导航栏的索引从0开始，顶部导航栏的索引从6开始
            ),
          ),
          
          // 搜索框和分类导航栏 - 只在首页和顶部导航视图中显示，覆盖在内容上方
          if (_shouldShowTopBar())
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // 半透明背景
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                ),
                child: Column(
                  children: [
                    Search(),
                    Category(onCategoryTap: (index) {
                      setState(() {
                        // 处理分类点击，更新索引以切换视图
                        if (index == 0) {
                          _bottomIndex = 0; // 推荐对应首页视图(索引0)
                        } else if (index >= 1 && index <= 9) {
                          // 底部导航栏占用0-5，顶部导航栏视图从6开始
                          // 分类索引1-9对应视图索引6-14
                          _bottomIndex = 5 + index;
                        }
                      });
                    }),
                  ],
                ),
              ),
            ),
        ],
      ),
      
      //底部导航栏
      bottomNavigationBar: Container(
        height: 56,
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, '首页', 0),
            _buildNavItem(Icons.explore, '发现', 1),
            _buildNavItem(Icons.movie, '看啥片', 2),
            _buildNavItem(Icons.live_tv, '直播', 3),
            _buildNavItem(Icons.games, '游戏', 4),
            _buildNavItem(Icons.person, '我的', 5),
          ],
        ),
      ),
    );
  }










// 实现底部导航栏的点击事件
  Widget _buildNavItem(IconData icon, String label, int index) {
    // 判断当前索引是否等于底部导航栏的索引
    bool isSelected = _bottomTabController.index == index;
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory, // 完全禁用涟漪效果
        ),
        onPressed: () {
          // 点击底部导航栏时，切换索引
          setState(() {
            //这里的index就是底部导航栏的当前索引
            // 切换底部导航栏的索引
            _bottomTabController.index = index;
            _bottomIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              // 选中时改变颜色,isSelected等于选择的标签当前索引时改变颜色
              color: isSelected ? Colors.red[200] : Colors.grey[600],
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.red[200] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }




}