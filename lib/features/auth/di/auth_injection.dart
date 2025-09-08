import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/biometric_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/mock_auth_repository.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/check_biometric_login.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/login_cubit.dart';


final sl = GetIt.instance;

Future<void> initAuth() async {
  // Blocs and Cubits
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => LoginCubit(sl(), sl()));

  // Use Cases
  sl.registerLazySingleton(() => CheckBiometricLogin(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>(), sl<MockAuthRepository>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<MockAuthRepository>(() => MockAuthRepository());

  // Data Sources
  sl.registerLazySingleton<BiometricDataSource>(() => BiometricDataSourceImpl(sl()));

  // External
  sl.registerLazySingleton(() => LocalAuthentication());
  sl.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}