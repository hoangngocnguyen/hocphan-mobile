import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart'; // Import bảng màu ShopEasy

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // 1. Khởi tạo AnimationController với thời gian 800ms
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // 2. Định nghĩa hiệu ứng mờ dần (Fade)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 3. Định nghĩa hiệu ứng trượt lên (Slide)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // 4. Chạy animation
    _controller.forward();
  }

  @override
  void dispose() {
    // BẮT BUỘC hủy controller để tránh rò rỉ bộ nhớ (memory leak)
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Dùng màu chủ đạo của ShopEasy
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // Logo hoặc icon tạm thời
                Icon(Icons.shopping_bag_rounded, size: 80, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'ShopEasy',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Mua sắm thông minh, thảnh thơi mua sắm',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
