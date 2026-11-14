import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const String _storageKey = 'is_dark_mode';

  final SharedPreferences preferences;
  bool _isDarkMode = false;

  ThemeController({required this.preferences}) {
    _isDarkMode = preferences.getBool(_storageKey) ?? false;
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await preferences.setBool(_storageKey, value);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    await setDarkMode(!_isDarkMode);
  }
}
