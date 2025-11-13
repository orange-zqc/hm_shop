import 'package:flutter/material.dart';

class PlayletView extends StatefulWidget {
  const PlayletView({super.key});

  @override
  State<PlayletView> createState() => _PlayletViewState();
}

class _PlayletViewState extends State<PlayletView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Playlet'),
    );
  }
}