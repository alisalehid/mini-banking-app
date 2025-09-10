import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/transaction_remote_data_source.dart';
import '../data/repositories/transaction_repository_impl.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/usecases/get_transactions.dart';
import '../presentation/bloc/transaction_bloc.dart';

final sl = GetIt.instance;

Future<void> initTransactionModule() async {
  // Remote data source
  sl.registerLazySingleton(() => TransactionRemoteDataSource(Dio()));

  // Repository (register as interface)
  sl.registerLazySingleton<TransactionRepository>(
        () => TransactionRepositoryImpl(sl()),
  );

  // Use case
  sl.registerLazySingleton(() => GetTransactions(sl()));

  // Bloc
  sl.registerFactory(() => TransactionBloc(sl()));
}
