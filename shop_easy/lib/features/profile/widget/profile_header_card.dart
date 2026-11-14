import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';

import 'quick_stat.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final String email;
  final String avatarUrl;
  final bool isLoggedIn;
  final VoidCallback onLogin;

  const ProfileHeaderCard({
    super.key,
    required this.userName,
    required this.email,
    required this.avatarUrl,
    required this.isLoggedIn,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFDDE6F1),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD6E0EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 54,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                width: 106,
                height: 106,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person_rounded,
                    size: 52,
                    color: AppColors.primary,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuickStat(label: 'Bài viết', value: '12'),
              QuickStat(label: 'Người theo dõi', value: '1.2K'),
              QuickStat(label: 'Đang theo dõi', value: '428'),
            ],
          ),
          const SizedBox(height: 18),
          if (!isLoggedIn)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
