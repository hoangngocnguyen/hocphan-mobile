import 'package:flutter/material.dart';

class Th7TextWidget extends StatelessWidget {
  const Th7TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Nguyễn Ngọc Huy Hoàng · 23T1080015',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.center,
    );
  }
}
