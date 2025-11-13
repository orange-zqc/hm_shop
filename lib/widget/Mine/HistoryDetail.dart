import 'package:flutter/material.dart';

class Historydetail extends StatefulWidget {
  const Historydetail({super.key});

  @override
  State<Historydetail> createState() => _HistorydetailState();
}

class _HistorydetailState extends State<Historydetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('播放记录'),
      ),
    ); 
  }
}