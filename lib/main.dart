import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'app/router.dart';
import 'core/theme/data/repositories/theme_repository.dart';
import 'core/theme/domain/entities/theme_mode.dart';
import 'core/theme/presentation/providers/theme_notifier.dart';
import 'core/theme/presentation/theme/app_colors.dart';
import 'features/auth/di/auth_injection.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';
import 'features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/usecases/get_transactions.dart';
import 'features/transactions/presentation/bloc/transaction_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAuth();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LoginCubit _authCubit;
  late final AuthBloc _authBloc;
  late final GoRouter _appRouter;

  late final TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<LoginCubit>();
    _authCubit.initialize();
    _authBloc = sl<AuthBloc>();
    _appRouter = createRouter(_authCubit);

    final dio = Dio();
    final remoteDataSource = TransactionRemoteDataSource(dio);
    final repository = TransactionRepositoryImpl(remoteDataSource);
    final getTransactions = GetTransactions(repository);
    _transactionBloc = TransactionBloc(getTransactions);
  }

  @override
  void dispose() {
    print('Disposing MyAppState');
    _authCubit.close();
    _authBloc.close();
    _transactionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>.value(value: _authCubit),
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<TransactionBloc>.value(value: _transactionBloc),
      ],
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
              routerConfig: _appRouter,
            );
          },
        ),
      ),
    );
  }
}
