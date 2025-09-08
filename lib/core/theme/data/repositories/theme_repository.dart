import '../../domain/entities/theme_mode.dart';
import '../../domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeRepositoryImpl implements ThemeRepository {
  static const String _themeModeKey = 'themeMode';

  @override
  Future<AppThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_themeModeKey);
    return AppThemeMode.values.firstWhere(
          (e) => e.toString() == mode,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
  }
}