import 'package:flutter/material.dart';
import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/domain/entities/theme_mode.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isBiometricEnabled = false;


  @override
  void initState() {
    super.initState();
    // Initialize isDarkMode based on the current theme
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    isDarkMode = themeNotifier.themeMode == AppThemeMode.dark;
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: AppColors.background(context),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// User Profile Card
            ///
            SizedBox(height: 100,),
            Card(
              color: AppColors.cardBackground(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  title: const Text(
                    "John sample",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("User account"),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Theme Switch Card
            Card(
              color: AppColors.cardBackground(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SwitchListTile(
                  title:  Text(isDarkMode ?"Dark Mode" : "Light mode"),
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() => isDarkMode = value);

                    themeNotifier.setThemeMode(
                      value ? AppThemeMode.dark : AppThemeMode.light,
                    );


                  },
                  activeColor: AppColors.lightAccent,
                  inactiveThumbColor: AppColors.lightText,
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),


            const SizedBox(height: 16),

            /// Biometric Login Switch Card
            Card(
              color: AppColors.cardBackground(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SwitchListTile(
                  title: const Text("Biometric Login"),
                  value: isBiometricEnabled,
                  onChanged: (value) {
                    setState(() => isBiometricEnabled = value);
                    // TODO: Add logic to enable/disable biometric login
                  },
                  activeColor: AppColors.lightAccent,
                  inactiveThumbColor: AppColors.lightText,
                  secondary: Icon(
                    Icons.fingerprint,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            const Spacer(),

            /// Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // TODO: Add logout logic
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
