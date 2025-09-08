import 'package:flutter/material.dart';

import '../../domain/entities/theme_mode.dart';
import '../../domain/repositories/theme_repository.dart';
import '../theme/app_colors.dart';


class ThemeNotifier extends ChangeNotifier {
  final ThemeRepository _repository;
  AppThemeMode _themeMode = AppThemeMode.system;

  ThemeNotifier(this._repository) {
    _loadTheme();
  }

  AppThemeMode get themeMode => _themeMode;

  ThemeData get currentTheme {
    switch (_themeMode) {
      case AppThemeMode.light:
        return AppColors.lightTheme;
      case AppThemeMode.dark:
        return AppColors.darkTheme;
      case AppThemeMode.system:
        return AppColors.lightTheme; // Overridden by MaterialApp's themeMode
    }
  }

  Future<void> _loadTheme() async {
    _themeMode = await _repository.getThemeMode();
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    await _repository.saveThemeMode(mode);
    notifyListeners();
  }
}