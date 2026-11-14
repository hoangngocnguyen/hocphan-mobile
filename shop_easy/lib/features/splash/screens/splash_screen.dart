import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/features/onboarding/screens/onboarding_screen.dart';

import '../../../core/constants/app_colors.dart';
import '../../main/screens/main_layout_screen.dart';

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

    // _navigateToHome();
    // Thay vì về home thì kiểm tra điều hướng sau khi chạy hiệu ứng
    _checkFirstTimeUser();
  }

  // Future<void> _navigateToHome() async {
  //   await Future.delayed(const Duration(seconds: 3));

  //   if (!mounted) return;

  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => const MainLayoutScreen(
  //         initialIndex: 0,
  //         isLoggedIn: false,
  //       ),
  //     ),
  //   );
  // }

  Future<void> _checkFirstTimeUser() async {
    // Đảm bảo chạy xong splash
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Lấy instance của SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Đọc trạng thái (default = false nếu mở app lần đầu)
    final bool seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    if (!mounted) return;

    if (seenOnboarding) {
      // Nếu xem onboarding rồi thì vô trang chủ
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: 
          (context) => const MainLayoutScreen(
            initialIndex: 0,
            isLoggedIn: false,
          )
        )
      );
    } else {
      // Nếu chưa xem lần nào -> Chuyển sang màn hình Onboarding
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
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
