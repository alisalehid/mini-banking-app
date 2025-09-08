import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/router.dart';
import 'core/theme/data/repositories/theme_repository.dart';
import 'core/theme/domain/entities/theme_mode.dart';
import 'core/theme/presentation/providers/theme_notifier.dart';
import 'core/theme/presentation/theme/app_colors.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize the cubit and router only once in the state object.
  late final LoginCubit _authCubit;
  late final GoRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = LoginCubit(LoginUseCase(MockAuthRepository()));
    _appRouter = buildRouter(_authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authCubit,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(ThemeRepositoryImpl()),
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Mini Banking App',
              theme: AppColors.lightTheme,
              darkTheme: AppColors.darkTheme,
              themeMode: themeNotifier.themeMode == AppThemeMode.system
                  ? ThemeMode.system
                  : (themeNotifier.themeMode == AppThemeMode.light
                  ? ThemeMode.light
                  : ThemeMode.dark),
              // Use the pre-initialized router instance.
              routerConfig: _appRouter,
            );
          },
        ),
      ),
    );
  }
}