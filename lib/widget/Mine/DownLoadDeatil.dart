import 'package:flutter/material.dart';

class DownLoadDeatil extends StatefulWidget {
  const DownLoadDeatil({super.key});

  @override
  State<DownLoadDeatil> createState() => _DownLoadDeatilState();
}

class _DownLoadDeatilState extends State<DownLoadDeatil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下载记录'),
      ),
    );
  }
}
