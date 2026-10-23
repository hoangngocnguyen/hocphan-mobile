import 'package:flutter/material.dart';

class Th8ContainerWidget extends StatelessWidget {
  const Th8ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 24), // margin ngang
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // bo góc 16
        border: Border.all(color: Colors.grey.shade300), // viền
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: const Text(
        'Bài 8: Trang trí với Container hoàn tất!',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
