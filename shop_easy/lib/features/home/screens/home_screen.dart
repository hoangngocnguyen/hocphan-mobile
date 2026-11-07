import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/auth/screens/register_screen.dart';

import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEasy - Trang chủ'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          // Nút Đăng nhập dạng TextButton có Icon
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            label: const Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          
          const SizedBox(width: 4),

          // Nút Đăng ký được làm nổi bật hơn với viền hoặc nền khác nhẹ
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const Text(
                'Đăng ký',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Chào mừng bạn đến với ShopEasy!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}