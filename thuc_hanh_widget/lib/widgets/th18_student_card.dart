import 'package:flutter/material.dart';

class Th18StudentCard extends StatelessWidget {
  const Th18StudentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 77, 214),
            Color.fromARGB(255, 18, 182, 160),
          ],
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://res.cloudinary.com/dojey70x3/image/upload/v1761365303/unnamed_hxhso1.png',
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nguyễn Ngọc Huy Hoàng',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),
          const Text(
            'Mã số: 23T1080015 - Lớp: KTPM - K47B',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã chọn: Liên hệ')),
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('Liên hệ'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã chọn: Chia sẻ')),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Chia sẻ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
