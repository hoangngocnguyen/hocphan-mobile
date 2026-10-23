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

  // Hàm phụ (helper widget) để vẽ một ô màu 80x80 kèm tên màu ở dưới đúng yêu cầu bài tập
  Widget _OMau(String tenMau, Color maMasc) {
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
            spacing: 16, // Khoảng cách theo chiều ngang giữa các ô
            runSpacing:
                16, // Khoảng cách theo chiều dọc khi xuống hàng[cite: 9]
            children: [
              _OMau('primary', AppColors.primary),
              _OMau('primaryLight', AppColors.primaryLight),
              _OMau('secondary', AppColors.secondary),
              _OMau('success', AppColors.success),
              _OMau('error', AppColors.error),
              _OMau('background', AppColors.background),
              _OMau('surface', AppColors.surface),
              _OMau('textPrimary', AppColors.textPrimary),
              _OMau('textSecondary', AppColors.textSecondary),
              _OMau('divider', AppColors.divider),
            ],
          ),
        ),
      ),
    );
  }
}
