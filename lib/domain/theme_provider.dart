import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const String _themeKey = "theme_mode";

  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  void toggleTheme() async {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      await _saveTheme(ThemeMode.dark);
    } else {
      state = ThemeMode.light;
      await _saveTheme(ThemeMode.light);
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_themeKey, mode == ThemeMode.light ? "light" : "dark");
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == "light") {
      state = ThemeMode.light;
    } else if (savedTheme == "dark") {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
