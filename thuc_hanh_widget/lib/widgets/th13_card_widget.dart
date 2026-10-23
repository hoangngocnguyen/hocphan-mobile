import 'package:flutter/material.dart';

class Th13CardWidget extends StatelessWidget {
  const Th13CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // đổ bóng
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Text('H')),
        title: const Text('Nguyễn Ngọc Huy Hoàng'),
        subtitle: const Text('23T1080015@husc.edu.vn'),
        trailing: IconButton(
          // đuôi
          icon: const Icon(Icons.phone),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gọi điện cho Nguyễn Ngọc Huy Hoàng'),
              ),
            );
          },
        ),
      ),
    );
  }
}
