import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/theme_mode.dart';
import '../providers/theme_notifier.dart';

class AppColors {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF000000); // Black (text/icons)
  static const Color lightAccent = Color(0xFFBF4C4C); // Green accent (health score bar)
  static const Color lightBackground = Color(0xFFF3F3F3); // White background
  static const Color lightText = Color(0xFF212121); // Dark grey text
  static const Color lightButton = Color(0xFF000000); // Black buttons (Done, etc.)
  static const Color lightTitleButton = Color(0xFFE0E0E0); // Deep blue for title buttons∂
  static const Color lightCardBackground = Color(0xFFFFFFFF);

// Dark theme colors
  static const Color darkPrimary = Color(0xFFFFFFFF); // White text/icons
  static const Color darkAccent = Color(0xFFBF4C4C); // Bright green accent
  static const Color darkBackground = Color(0xFF121212); // Dark background
  static const Color darkText = Color(0xFFE0E0E0); // Light grey text
  static const Color darkButton = Color(0xFFFFFFFF); // White buttons
  static const Color darkTitleButton = Color(0xFFFFFFFF);
  static const Color darkCardBackground = Color(0xFF191919);






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

  static Color cardBackground(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkCardBackground
          : lightCardBackground;
    }

    return themeNotifier.themeMode == AppThemeMode.dark
        ? darkCardBackground
        : lightCardBackground;
  }

  static Color background(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkBackground
          : lightBackground;
    }

    return themeNotifier.themeMode == AppThemeMode.dark
        ? darkBackground
        : lightBackground;
  }


  static LinearGradient backgroundGradient(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    if (themeNotifier.themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkBackgroundGradient
          : lightBackgroundGradient;
    }

    return themeNotifier.themeMode == AppThemeMode.dark
        ? darkBackgroundGradient
        : lightBackgroundGradient;
  }

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF4F4F4), // Pure white (top)
      Color(0xFFF4F4F4), // Very light gray (middle)
    ],
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E1E1E), // A very dark gray/black
      Color(0xFF0D0D0D), // Slightly lighter dark gray (bottom)
    ],
  );

}