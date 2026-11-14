import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppColorsScreen(),
    );
  }
}

class AppColorsScreen extends StatelessWidget {
  const AppColorsScreen({super.key});

  Widget _oMau(String tenMau, Color maMasc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: maMasc,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tenMau,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TH 20: Bảng Màu ShopEasy'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16, 
            runSpacing:
                16, // Khoảng cách theo chiều dọc khi xuống hàng
            children: [
              _oMau('primary', AppColors.primary),
              _oMau('primaryLight', AppColors.primaryLight),
              _oMau('secondary', AppColors.secondary),
              _oMau('success', AppColors.success),
              _oMau('error', AppColors.error),
              _oMau('background', AppColors.background),
              _oMau('surface', AppColors.surface),
              _oMau('textPrimary', AppColors.textPrimary),
              _oMau('textSecondary', AppColors.textSecondary),
              _oMau('divider', AppColors.divider),
            ],
          ),
        ),
      ),
    );
  }
}
