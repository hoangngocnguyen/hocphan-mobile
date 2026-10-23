import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../home/screens/home_screen.dart';

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
  late Animation<double> _loadingFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Giai đoạn 1 (0% -> 40% thời gian): Logo hiện mờ dần (Fade In)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Giai đoạn 2 (30% -> 70% thời gian): Slogan trượt từ dưới lên (Slide Up)
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    // Giai đoạn 3 (60% -> 100% thời gian): Loading Indicator xuất hiện
    _loadingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    // Chạy chuỗi Animation
    _controller.forward();

    // Chuyển sang HomeScreen sau 3 giây
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    // BẮT BUỘC kiểm tra mounted trước khi gọi Navigator để tránh lỗi Context
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Giai đoạn 1: Logo Fade In
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Icon(
                Icons.shopping_bag_rounded,
                size: 90,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Giai đoạn 2: Tên & Slogan Slide Up
            SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: const [
                  Text(
                    'ShopEasy',
                    style: TextStyle(
                      fontSize: 36,
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
            const SizedBox(height: 48),

            // Giai đoạn 3: Loading Indicator Fade In
            FadeTransition(
              opacity: _loadingFadeAnimation,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
