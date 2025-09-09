import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_banking_app/features/local_transactions/presentation/bloc/dashboard/local_transactions_dashboard_event.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'features/auth/di/auth_injection.dart' as auth_di;
import 'features/local_transactions/di/injection.dart' as local_tx_di;

import 'app/router.dart';
import 'core/theme/data/repositories/theme_repository.dart';
import 'core/theme/domain/entities/theme_mode.dart';
import 'core/theme/presentation/providers/theme_notifier.dart';
import 'core/theme/presentation/theme/app_colors.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';

// ✅ Make sure you import both bloc + event
import 'features/local_transactions/presentation/bloc/dashboard/local_transactions_dashboard_bloc.dart';
import 'features/local_transactions/presentation/bloc/transfer/local_transactions_transfer_bloc.dart';

import 'features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/usecases/get_transactions.dart';
import 'features/transactions/presentation/bloc/transaction_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize feature injections
  await auth_di.initAuth();
  await local_tx_di.initLocalTransactionsModule();

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

    // Auth cubit and bloc
    _authCubit = auth_di.sl<LoginCubit>();
    _authCubit.initialize();
    _authBloc = auth_di.sl<AuthBloc>();

    // Router
    _appRouter = createRouter(_authCubit);

    // Transaction bloc (remote API)
    final dio = Dio();
    final remoteDataSource = TransactionRemoteDataSource(dio);
    final repository = TransactionRepositoryImpl(remoteDataSource);
    final getTransactions = GetTransactions(repository);
    _transactionBloc = TransactionBloc(getTransactions);
  }

  @override
  void dispose() {
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

        BlocProvider<LocalTransactionsDashboardBloc>(
          create: (_) => local_tx_di.sl<LocalTransactionsDashboardBloc>()
            ..add(LocalTransactionsDashboardEvent as LocalTransactionsDashboardEvent),
        ),
        BlocProvider<LocalTransactionsTransferBloc>(
          create: (_) => local_tx_di.sl<LocalTransactionsTransferBloc>(),
        ),
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
