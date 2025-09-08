import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/biometric_result.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    return username == "user@test.com" && password == "123456";
  }

  @override
  Future<Either<Failure, BiometricResult>> checkBiometricSupport() async {
    return Left(BiometricFailure('Biometric support not available in mock repository'));
  }

  @override
  Future<Either<Failure, BiometricResult>> authenticateWithBiometrics() async {
    return Left(BiometricFailure('Biometric authentication not available in mock repository'));
  }
}