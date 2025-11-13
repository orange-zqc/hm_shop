import 'package:flutter/material.dart';

class CollectionDetail extends StatefulWidget {
  const CollectionDetail({super.key});

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏'),
      ),
    );
  }
}
