import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';
import 'package:shop_easy/features/cart/screens/cart_screen.dart';
import 'package:shop_easy/features/profile/widget/profile_header_card.dart';
import 'package:shop_easy/features/profile/widget/profile_menu_item.dart';
import 'package:shop_easy/features/settings/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final bool isLoggedIn;

  const ProfileScreen({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    final userName = isLoggedIn ? 'Hoàng Nguyễn' : 'Khách hàng';
    final email = isLoggedIn
        ? 'hoang.nguyen@gmail.com'
        : 'Vui lòng đăng nhập để trải nghiệm đầy đủ';
    const avatarUrl =
        'https://res.cloudinary.com/dojey70x3/image/upload/v1794666881/Avatar_vptggz.jpg';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Hồ sơ cá nhân',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
        ),
        actions: [
          if (isLoggedIn)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeaderCard(
                userName: userName,
                email: email,
                avatarUrl: avatarUrl,
                isLoggedIn: isLoggedIn,
                onLogin: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),
              ProfileMenuItem(
                icon: Icons.local_shipping_rounded,
                title: 'Đơn hàng',
                subtitle: '03 đơn đang xử lý',
                accent: const Color(0xFF3B82F6),
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Địa chỉ giao hàng',
                subtitle: 'Số 28, Tòa nhà...',
                accent: const Color(0xFFF59E0B),
                onTap: () {},
              ),

              ProfileMenuItem(
                icon: Icons.payment_rounded,
                title: 'Phương thức thanh toán',
                subtitle: 'Mastercard •••• 8451',
                accent: const Color(0xFF10B981),
                onTap: () {},
              ),

              ProfileMenuItem(
                icon: Icons.favorite_rounded,
                title: 'Sản phẩm yêu thích',
                subtitle: '12 sản phẩm',
                accent: const Color(0xFFEC4899),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
