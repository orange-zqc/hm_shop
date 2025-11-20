import 'package:flutter/material.dart';

import 'package:hmshop/widget/Live/LiveHome.dart';


class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('开端放映厅🎥')),
      ),
      body: Livehome(),
    );
  }
}