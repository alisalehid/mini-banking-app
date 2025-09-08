import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/presentation/providers/theme_notifier.dart';
import '../../../../core/theme/presentation/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/rounded_loading_button.dart';
import '../bloc/login_cubit.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/mock_auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // No need to create a new Cubit here, as it's provided in main.dart.
    return const _LoginView();
  }
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (!state.isLoading) {
                _loadingController.reset();
              }

              if (state.error != null) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }

              if (state.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login successful!"),
                    duration: Duration(seconds: 3),
                  ),
                );
                // Navigate to the dashboard, which is part of the ShellRoute.
                context.go('/dashboard');
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/bank.png',
                    width: 100,
                    height: 100,
                  ),
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
                  const SizedBox(height: 100),
                  CustomTextField(
                    label: "Username",
                    controller: _usernameController,
                    hint: "Enter username",
                    errorText: state.usernameError,
                    onChanged: cubit.usernameChanged,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Password",
                    controller: _passwordController,
                    hint: "Enter password",
                    obscureText: true,
                    errorText: state.passwordError,
                    onChanged: cubit.passwordChanged,
                  ),
                  const SizedBox(height: 40),
                  CustomLoadingButton(
                    controller: _loadingController,
                    title: "Login",
                    titleColor: AppColors.titleButtonColor(context),
                    fillColor: state.isValid
                        ? AppColors.buttonColor(context)
                        : AppColors.buttonColor(context),
                    onTap: state.isValid
                        ? () {
                      _loadingController.start();
                      cubit.login();
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
}