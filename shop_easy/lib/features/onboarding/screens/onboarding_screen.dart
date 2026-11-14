import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/features/main/screens/main_layout_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Dữ liệu cho 3 trang giới thiệu
  final List _onboardingData = [
    {
      'title': 'Mua sắm dễ dàng',
      'description': 'Khám phá hàng ngàn sản phẩm chất lượng cao với mức giá tốt nhất chỉ với vài cú chạm.',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Thanh toán an toàn',
      'description': 'Hỗ trợ nhiều phương thức thanh toán bảo mật, nhanh chóng và cực kỳ tiện lợi.',
      'icon': Icons.payment_outlined,
    },
    {
      'title': 'Giao hàng siêu tốc',
      'description': 'Đơn hàng của bạn sẽ được đóng gói và vận chuyển đến tận cửa nhà trong thời gian ngắn nhất.',
      'icon': Icons.local_shipping_outlined,
    },
  ];

  Future<void> _completeOnboarding() async {
    // 1. Lưu lại trạng thái đã xem Onboarding để lần sau không hiện nữa
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);

    if (!mounted) return;

    // 2. Chuyển về màn hình chính (MainLayoutScreen) và xóa sạch lịch sử stack trước đó
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainLayoutScreen(
          initialIndex: 0,
          isLoggedIn: false, // Hoặc trạng thái đăng nhập thực tế của bạn
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Nút "Bỏ qua" ở góc trên bên phải
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentIndex < _onboardingData.length - 1)
                    TextButton(
                      onPressed: () {
                        _completeOnboarding();
                      },
                      child: const Text(
                        'Bỏ qua',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),

            // PageView chứa 3 trang giới thiệu
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey<int>(index),
                            height: 260,
                            width: 260,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _onboardingData[index]['icon'],
                              size: 90,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Tiêu đề
                        Text(
                          _onboardingData[index]['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Mô tả ngắn
                        Text(
                          _onboardingData[index]['description']!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Phần dưới: Dấu chấm và Nút bấm chuyển/bắt đầu
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dấu chấm chỉ trang hiện tại (Trang nào chọn sẽ dài hơn và đổi màu)
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        height: 8,
                        width: _currentIndex == index
                            ? 24
                            : 8, // Đang chọn thì dài hơn
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? AppColors
                                    .primary // Màu chủ đạo của app
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Nút chuyển tiếp / Nút "Bắt đầu" ở trang cuối
                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < _onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      _currentIndex == _onboardingData.length - 1
                          ? 'Bắt đầu'
                          : 'Tiếp tục',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
