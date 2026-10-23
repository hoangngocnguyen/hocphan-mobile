import 'package:flutter/material.dart';
import 'package:shop_easy/features/splash/screens/splash_screen.dart';

import 'core/theme/app_theme.dart'; // Đảm bảo bạn đã có file app_theme.dart

void main() {
  // Đảm bảo Flutter engine khởi tạo trước khi chạy code platform-specific
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ShopEasyApp());
}

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ShopEasy',
    debugShowCheckedModeBanner: false, // Ấn banner DEBUG ở góc màn hình
    theme: AppTheme.lightTheme,
    home: const SplashScreen(), // Hiển thị màn hình Splash khi mở app
  );
}
