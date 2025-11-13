import 'package:flutter/material.dart';

class BenefitsView extends StatefulWidget {
  const BenefitsView({super.key});

  @override
  State<BenefitsView> createState() => _BenefitsState();
}

class _BenefitsState extends State<BenefitsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('福利'),
    );
  }
}