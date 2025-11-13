import 'package:flutter/material.dart';


//电视剧
class TvDramaView extends StatefulWidget {
  const TvDramaView({super.key});

  @override
  State<TvDramaView> createState() => _TvDramaViewState();
}

class _TvDramaViewState extends State<TvDramaView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('电视剧'),
    );
  }
}