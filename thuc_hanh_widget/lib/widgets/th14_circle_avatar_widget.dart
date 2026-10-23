import 'package:flutter/material.dart';

class Th14CircleAvatarWidget extends StatelessWidget {
  const Th14CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // K1: ảnh kèm viền trắng ngoài
        CircleAvatar(
          radius: 52,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(
              'https://res.cloudinary.com/dojey70x3/image/upload/v1761365303/unnamed_hxhso1.png',
            ),
          ),
        ),
        const SizedBox(width: 20),

        // K2: chỉ có chữ cái trên nền màu
        const CircleAvatar(
          radius: 48,
          backgroundColor: Colors.blue,
          child: Text(
            'Hoàng',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
