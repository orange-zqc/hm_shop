import 'package:flutter/material.dart';

class NetflixView extends StatefulWidget {
  const NetflixView({super.key});

  @override
  State<NetflixView> createState() => _NetflixViewState();
}

class _NetflixViewState extends State<NetflixView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(' Netflix'),
    );
  }
}