import 'package:get_it/get_it.dart';
import '../infrastructure/db/local_transactions_db.dart';
import '../infrastructure/db/daos/balance_dao.dart';
import '../infrastructure/db/daos/transaction_dao.dart';
import '../data/repositories/local_transactions_repository_impl.dart';
import '../domain/repositories/local_transactions_repository.dart';
import '../domain/usecases/get_local_transactions_balance.dart';
import '../domain/usecases/get_local_transactions_recent_transactions.dart';
import '../domain/usecases/send_local_transactions_money.dart';
import '../presentation/bloc/dashboard/local_transactions_dashboard_bloc.dart';
import '../presentation/bloc/transfer/local_transactions_transfer_bloc.dart';



final sl = GetIt.instance;

/// Call this once during app startup.
Future<void> initLocalTransactionsModule() async {
  // ----- Infrastructure (Drift DB + DAOs) -----
  sl.registerLazySingleton<LocalTransactionsDb>(() => LocalTransactionsDb());
  sl.registerLazySingleton<BalanceDao>(() => BalanceDao(sl()));
  sl.registerLazySingleton<TransactionDao>(() => TransactionDao(sl()));

  // ----- Repository -----
  sl.registerLazySingleton<LocalTransactionsRepository>(() => LocalTransactionsRepositoryImpl(
    db: sl(),
    balanceDao: sl(),
    transactionDao: sl(),
  ));

  // ----- Use cases -----
  sl.registerLazySingleton(() => GetLocalTransactionsBalance(sl()));
  sl.registerLazySingleton(() => GetLocalTransactionsRecentTransactions(sl()));
  sl.registerLazySingleton(() => SendLocalTransactionsMoney(sl()));

  // ----- Presentation (BLoCs) -----
  sl.registerFactory(() => LocalTransactionsDashboardBloc(
    getBalance: sl(),
    getRecent: sl(),
  ));

  sl.registerFactory(() => LocalTransactionsTransferBloc(
    getBalance: sl(),
    sendMoney: sl(),
    onSuccessNavigateBack: null, // router handles navigation in page
    onSuccessRefreshDashboard: null,
  ));
}
