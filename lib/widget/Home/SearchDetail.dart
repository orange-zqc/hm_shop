import 'package:flutter/material.dart';
import 'package:hmshop/viewmodels/VedioBean.dart';
import 'package:hmshop/widget/Live/PlayDetail.dart';


class SearchDetail extends StatefulWidget {
  final SearchDetailBean searchItem;

  const SearchDetail({super.key, required this.searchItem});

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {



  @override
  void initState() {
    super.initState();

    
  }

  @override
  void dispose() {
    super.dispose();
  }
    // 处理简介文本，避免索引越界错误
  String _getSafeIntroText(String? intro) {
    if (intro == null || intro.isEmpty) {
      return '暂无简介';
    }
    
    try {
      if (intro.length > 60) {
        return '简介: ${intro.substring(0, 60)}...';
      } else {
        return '简介: $intro';
      }
    } catch (e) {
      // 如果出现任何异常，返回安全的替代文本
      return '简介: ${intro}';
    }
  }


  @override
  Widget build(BuildContext context) {
    return 
    Container( 
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 电影图片
          Container(
            margin: const EdgeInsets.all(8),
            height: 140,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              //如果图片为空，显示默认图标
              image: widget.searchItem.img != null && widget.searchItem.img!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(widget.searchItem.img!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            // 如果图片为空，显示默认图标
            child: widget.searchItem.img == null || widget.searchItem.img!.isEmpty
                ? const Center(child: Icon(Icons.movie, size: 40, color: Colors.grey))
                : null,
          ),
          
          // 电影信息
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // 电影名称
                  Text(
                    widget.searchItem.name ?? '未知名称',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  
                  // 导演信息
                  Text(
                    '导演: ${widget.searchItem.director ?? '未知'}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // 主演信息
                  Text(
                    '主演: ${widget.searchItem.actor ?? '未知'}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // 年份、地区、类型
                  Text(
                    '${widget.searchItem.year ?? ''} / ${widget.searchItem.area ?? ''} / ${widget.searchItem.type ?? ''}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // 时长信息
                  Text(
                    '时长: ${widget.searchItem.duration ?? '未知'}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                  ),
                  
                  // 简介（只显示前60个字符）
                  Text(
                    '${_getSafeIntroText(widget.searchItem.content ?? '')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
 
      }

  }

