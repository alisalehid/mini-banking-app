import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/theme_mode.dart';
import '../providers/theme_notifier.dart';

class AppColors {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF000000); // Black (text/icons)
  static const Color lightAccent = Color(0xFF00C853); // Green accent (health score bar)
  static const Color lightBackground = Color(0xFFFFFFFF); // White background
  static const Color lightText = Color(0xFF212121); // Dark grey text
  static const Color lightButton = Color(0xFF000000); // Black buttons (Done, etc.)
  static const Color lightTitleButton = Color(0xFFE0E0E0); // Deep blue for title buttons

// Dark theme colors
  static const Color darkPrimary = Color(0xFFFFFFFF); // White text/icons
  static const Color darkAccent = Color(0xFF00E676); // Bright green accent
  static const Color darkBackground = Color(0xFF121212); // Dark background
  static const Color darkText = Color(0xFFE0E0E0); // Light grey text
  static const Color darkButton = Color(0xFFFFFFFF); // White buttons
  static const Color darkTitleButton = Color(0xFF212121); // Light blue for title buttons



  // ThemeData for light mode
  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightAccent,
      background: lightBackground,
    ),
    scaffoldBackgroundColor: lightBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightText),
      bodyMedium: TextStyle(color: lightText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(lightButton),
        foregroundColor: WidgetStateProperty.all(lightText),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(lightTitleButton),
        overlayColor: WidgetStateProperty.all(lightTitleButton.withOpacity(0.1)),
      ),
    ),
  );

  // ThemeData for dark mode
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkAccent,
      background: darkBackground,
    ),
    scaffoldBackgroundColor: darkBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: darkText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(darkButton),
        foregroundColor: WidgetStateProperty.all(darkText),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(darkTitleButton),
        overlayColor: WidgetStateProperty.all(darkTitleButton.withOpacity(0.1)),
      ),
    ),
  );

  // Getters for theme-dependent colors
  static Color textColor(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkText
          : lightText;
    }
    return themeNotifier.themeMode == AppThemeMode.dark ? darkText : lightText;
  }

  static Color buttonColor(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkButton
          : lightButton;
    }
    return themeNotifier.themeMode == AppThemeMode.dark ? darkButton : lightButton;
  }

  static Color titleButtonColor(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkTitleButton
          : lightTitleButton;
    }
    return themeNotifier.themeMode == AppThemeMode.dark ? darkTitleButton : lightTitleButton;
  }
}