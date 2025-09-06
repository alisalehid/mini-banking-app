import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'colors.dart';

enum AppTheme { light, dark }

class ThemeCubit extends HydratedCubit<AppTheme> {
  ThemeCubit() : super(AppTheme.light) {
    // Initialize with system brightness
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    emit(brightness == Brightness.dark ? AppTheme.dark : AppTheme.light);
  }

  void toggleTheme() {
    emit(state == AppTheme.light ? AppTheme.dark : AppTheme.light);
  }

  ThemeData get currentThemeData => state == AppTheme.light ? _lightTheme : _darkTheme;

  ThemeData get _lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
    ),
  );

  ThemeData get _darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.textDark,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accent,
    ),
  );

  @override
  AppTheme? fromJson(Map<String, dynamic> json) {
    return AppTheme.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic>? toJson(AppTheme state) {
    return {'theme': state.index};
  }
}