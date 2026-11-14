import 'package:flutter/material.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/features/home/screens/home_screen.dart';
import 'package:shop_easy/features/notifications/screens/notifications_screen.dart';
import 'package:shop_easy/features/profile/screens/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  final int initialIndex;
  final bool isLoggedIn;

  const MainLayoutScreen({
    super.key,
    this.initialIndex = 0,
    this.isLoggedIn = false,
  });

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(isLoggedIn: widget.isLoggedIn),
      const NotificationsScreen(),
      ProfileScreen(isLoggedIn: widget.isLoggedIn),
    ];

    return Scaffold(
      body: IndexedStack( // giữ toàn bộ danh sách màn hình trong bộ nhớ, chỉ hiển thị màn hình theo index hiện tại -> chuyển tab không reload
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider),
          ),
        ),
        child: SafeArea(
          child: NavigationBar(
            height: 72,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index; // bấm nút bên dưới thay đổi index -> chuyển trang
              });
            },
            backgroundColor: AppColors.surface,
            indicatorColor: AppColors.primaryLight,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Trang chủ',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_none_rounded),
                selectedIcon: Icon(Icons.notifications_rounded),
                label: 'Thông báo',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Tôi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
