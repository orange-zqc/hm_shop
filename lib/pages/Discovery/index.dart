import 'package:flutter/material.dart';

class DiscoveryView extends StatefulWidget {
  const DiscoveryView({super.key});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('发现'),
    );
  }
}