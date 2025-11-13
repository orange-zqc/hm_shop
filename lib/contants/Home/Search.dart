import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
    /// 导航到搜索页面方法
    void _navigateToSearchPage() {
   
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.01),
      padding: const EdgeInsets.only(top: 30, bottom: 2, left: 9.0, right: 8.0),
      child: Row(
        children: [
          // 网站logo
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.01),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: AssetImage('lib/assets/轮播1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 6),
          // 网站名称
          Text('kekys.com', style: TextStyle(color: Colors.purple[300], fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(width: 6),
          // 搜索框
          Expanded(
            child: GestureDetector(
              onTap: _navigateToSearchPage,
              child: Container(
                height: 27,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.8), width: 1),
                    color: Colors.grey.withOpacity(0.01),

                ),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 搜索图标,将搜索图标和文本框隔开
                    Expanded(
                      flex: 7,
                      child: Text('搜索您想看的影片', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 13)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.search, color: Colors.grey[700], size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}