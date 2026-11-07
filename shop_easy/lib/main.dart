import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/features/splash/screens/splash_screen.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(preferences: prefs),
      child: const ShopEasyApp(),
    ),
  );
}

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      title: 'ShopEasy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      home: const SplashScreen(),
    );
  }
}
