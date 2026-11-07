import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_easy/core/constants/app_colors.dart';
import 'package:shop_easy/core/theme/theme_controller.dart';
import 'package:shop_easy/features/auth/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationsEnabled = true;
  bool _isRememberLoginEnabled = true;

  String _selectedLanguage = 'Tiếng Việt';
  String _selectedFontSize = 'Vừa';

  void _showSelectionBottomSheet({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const Divider(),
                ...options.map((option) {
                  final isSelected = option == currentValue;
                  return ListTile(
                    title: Text(
                      option,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'ShopEasy',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.shopping_bag, color: AppColors.primary, size: 40),
      children: const [
        Text('Ứng dụng mua sắm tiện lợi, nhanh chóng và an toàn cho người dùng.'),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi tài khoản không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Cài đặt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
            child: Text(
              'TÀI KHOẢN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                letterSpacing: 0.8,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Nhận thông báo', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text('Nhận thông báo về đơn hàng và khuyến mãi', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(180))),
                  value: _isNotificationsEnabled,
                  activeThumbColor: AppColors.primary,
                  activeTrackColor: AppColors.primaryLight,
                  onChanged: (bool value) {
                    setState(() {
                      _isNotificationsEnabled = value;
                    });
                  },
                ),
                Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: Colors.grey.shade200),
                SwitchListTile(
                  title: Text('Chế độ tối', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text('Giao diện tối giúp dịu mắt khi dùng ban đêm', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(180))),
                  value: themeController.isDarkMode,
                  activeThumbColor: AppColors.primary,
                  activeTrackColor: AppColors.primaryLight,
                  onChanged: (bool value) {
                    themeController.setDarkMode(value);
                  },
                ),
                Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: Colors.grey.shade200),
                SwitchListTile(
                  title: Text('Nhớ đăng nhập', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text('Giữ phiên đăng nhập của bạn trên thiết bị này', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withAlpha(180))),
                  value: _isRememberLoginEnabled,
                  activeThumbColor: AppColors.primary,
                  activeTrackColor: AppColors.primaryLight,
                  onChanged: (bool value) {
                    setState(() {
                      _isRememberLoginEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
            child: Text(
              'ỨNG DỤNG',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                letterSpacing: 0.8,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text('Ngôn ngữ', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedLanguage, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    _showSelectionBottomSheet(
                      title: 'Chọn ngôn ngữ',
                      options: ['Tiếng Việt', 'English', '日本語'],
                      currentValue: _selectedLanguage,
                      onSelected: (value) {
                        setState(() {
                          _selectedLanguage = value;
                        });
                      },
                    );
                  },
                ),
                Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: Colors.grey.shade200),
                ListTile(
                  title: Text('Cỡ chữ', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedFontSize, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(180), fontSize: 14)),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    _showSelectionBottomSheet(
                      title: 'Chọn cỡ chữ',
                      options: ['Nhỏ', 'Vừa', 'Lớn'],
                      currentValue: _selectedFontSize,
                      onSelected: (value) {
                        setState(() {
                          _selectedFontSize = value;
                        });
                      },
                    );
                  },
                ),
                Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: Colors.grey.shade200),
                ListTile(
                  title: Text('Về ứng dụng', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: _showAboutDialog,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          OutlinedButton(
            onPressed: _showLogoutDialog,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}