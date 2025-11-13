import 'package:flutter/material.dart';
//院线上新
class NewlyLaunchedView extends StatefulWidget {
  const NewlyLaunchedView({super.key});

  @override
  State<NewlyLaunchedView> createState() => _NewlyLaunchedViewState();
}

class _NewlyLaunchedViewState extends State<NewlyLaunchedView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('新线'),
    );
  }
}
