import 'package:flutter/material.dart';

class Th11AppBarActionWidget extends StatelessWidget {
  const Th11AppBarActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Tìm kiếm',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bạn vừa bấm Tìm kiếm'),
              ), // Hiện thông báo
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          tooltip: 'Thông báo',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bạn vừa bấm Thông báo')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.blue, size: 26),
          tooltip: 'Cài đặt',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bạn vừa bấm Cài đặt')),
            );
          },
        ),
      ],
    );
  }
}
