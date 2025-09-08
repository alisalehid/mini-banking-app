import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/biometric_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/biometric_datasource.dart';
import '../models/biometric_result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BiometricDataSource biometricDataSource;

  AuthRepositoryImpl(this.biometricDataSource);

  @override
  Future<bool> login(String username, String password) async {
    throw UnimplementedError('Login not implemented in AuthRepositoryImpl');
  }

  @override
  Future<Either<Failure, BiometricResult>> checkBiometricSupport() async {
    try {
      final result = await biometricDataSource.checkBiometricSupport();
      return Right(result);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BiometricResult>> authenticateWithBiometrics() async {
    try {
      final result = await biometricDataSource.authenticateWithBiometrics();
      return Right(result);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }
}