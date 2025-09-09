import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/rounded_loading_button.dart';
import '../../../../core/theme/presentation/providers/theme_notifier.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => const _LoginView();
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loadingController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (!state.isLoading) _loadingController.reset();

              if (state.error != null) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }

              if (state.success) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login successful!")),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/bank.png', width: 100, height: 100),
                  const SizedBox(height: 20),
                  Text(
                    "Banking App",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: AppColors.textColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Secure Banking",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.textColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // 🔹 Fingerprint login button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      if (!authState.isBiometricEnabled || !authState.isBiometricSupported) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: IconButton(
                          icon: Icon(Icons.fingerprint,
                              size: 40, color: AppColors.buttonColor(context)),
                          onPressed: state.isLoading ? null : () {
                            _loadingController.start();
                            loginCubit.loginWithBiometrics();
                          },
                          tooltip: 'Login with Fingerprint',
                        ),
                      );
                    },
                  ),

                  // 🔹 Username/password fields
                  CustomTextField(
                    label: "Username",
                    controller: _usernameController,
                    hint: "Enter username",
                    errorText: state.usernameError,
                    onChanged: loginCubit.usernameChanged,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Password",
                    controller: _passwordController,
                    hint: "Enter password",
                    obscureText: true,
                    errorText: state.passwordError,
                    onChanged: loginCubit.passwordChanged,
                  ),
                  const SizedBox(height: 40),

                  // 🔑 Login button
                  CustomLoadingButton(
                    controller: _loadingController,
                    title: "Login",
                    titleColor: AppColors.titleButtonColor(context),
                    fillColor: state.isValid
                        ? AppColors.buttonColor(context)
                        : AppColors.buttonColor(context).withOpacity(0.5),
                    onTap: state.isValid
                        ? () {
                      _loadingController.start();
                      loginCubit.loginWithCredentials();
                    }
                        : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
