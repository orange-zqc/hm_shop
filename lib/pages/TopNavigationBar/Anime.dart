import 'package:flutter/material.dart';

//动画
class AnimeView extends StatefulWidget {
  const AnimeView({super.key});

  @override
  State<AnimeView> createState() => _AnimeViewState();
}

class _AnimeViewState extends State<AnimeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('动画'),
    );
  }
}