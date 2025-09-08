import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:mini_banking_app/core/theme/presentation/theme/app_colors.dart';
import '../../../../core/theme/domain/entities/theme_mode.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/bloc/login_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // Initialize dark mode state
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    isDarkMode = themeNotifier.themeMode == AppThemeMode.dark;

    // Check biometric support on init
    context.read<AuthBloc>().add(CheckBiometricSupport());
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background(context),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),

                /// Profile card
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

                /// Dark/Light mode toggle
                Card(
                  color: AppColors.cardBackground(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SwitchListTile(
                      title: Text(themeNotifier.themeMode == AppThemeMode.dark
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themeNotifier.themeMode == AppThemeMode.dark,
                      onChanged: (value) {
                        themeNotifier.setThemeMode(
                          value ? AppThemeMode.dark : AppThemeMode.light,
                        );
                      },
                      activeColor: AppColors.lightAccent,
                      inactiveThumbColor: AppColors.lightText,
                      secondary: Icon(
                        themeNotifier.themeMode == AppThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Biometric toggle
                Card(
                  color: AppColors.cardBackground(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text("Biometric Login"),
                          value: state.isBiometricEnabled,
                          onChanged: state.isBiometricSupported
                              ? (value) {
                            context.read<AuthBloc>().add(
                              ToggleBiometricLogin(value),
                            );
                          }
                              : null,
                          activeColor: AppColors.lightAccent,
                          inactiveThumbColor: AppColors.lightText,
                          secondary: Icon(
                            Icons.fingerprint,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (!state.isBiometricSupported)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Biometric authentication is not available on this device",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                /// Logout button
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
                    onPressed: () async {
                      // Get the LoginCubit instance
                      final loginCubit = context.read<LoginCubit>();

                      // Call logout
                      await loginCubit.logout();

                      // Optional: Navigate back to login screen
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
