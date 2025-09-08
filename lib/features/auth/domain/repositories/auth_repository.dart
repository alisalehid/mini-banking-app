import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/biometric_result.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<Either<Failure, BiometricResult>> checkBiometricSupport();
  Future<Either<Failure, BiometricResult>> authenticateWithBiometrics();
}