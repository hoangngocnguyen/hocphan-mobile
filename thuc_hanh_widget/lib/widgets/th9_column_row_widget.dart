import 'package:flutter/material.dart';

class Th9ColumnRowWidget extends StatelessWidget {
  const Th9ColumnRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: const [
            Icon(Icons.person_outline, size: 20),
            SizedBox(width: 12),
            Text('Họ tên: Nguyễn Ngọc Huy Hoàng'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Icon(Icons.school_outlined, size: 20),
            SizedBox(width: 12),
            Text('Lớp: Kỹ thuật phần mềm K47B'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Icon(Icons.email_outlined, size: 20),
            SizedBox(width: 12),
            Text('Email: 23T1080015@husc.edu.vn'),
          ],
        ),
      ],
    );
  }
}
