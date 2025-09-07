import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_banking_app/core/widgets/custom_text_field.dart';
import 'package:mini_banking_app/core/widgets/rounded_loading_button.dart';

import '../../../../core/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loadingController = RoundedLoadingButtonController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Image.asset(
                'assets/images/bank.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              Text(
                "Banking App",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    letterSpacing: .5,
                  ),
                ),
                textAlign: TextAlign.center,
              ),

              Text(
                "Secure Banking",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: AppColors.textLight2,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: .5,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 130),

              CustomTextField(
                label: "username",
                controller: _usernameController,
                hint: "Enter your username",
              ),

              const SizedBox(height: 16),

              CustomTextField(
                label: "password",
                controller: _passwordController,
                hint: "Enter your password",
              ),

              const SizedBox(height: 50),

              CustomLoadingButton(
                controller: _loadingController,
                title: "Login",
                titleColor: AppColors.textDark,
                fillColor: Colors.black,
              ),

              TextButton(
                onPressed: () {
                  // Handle forgot password logic
                },
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.nunito(
                    color: AppColors.textLight,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
