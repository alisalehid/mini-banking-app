import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/biometric_result.dart';
import '../repositories/auth_repository.dart';

class CheckBiometricLogin {
  final AuthRepository repository;

  CheckBiometricLogin(this.repository);

  Future<Either<Failure, BiometricResult>> checkSupport() async {
    return await repository.checkBiometricSupport();
  }

  Future<Either<Failure, BiometricResult>> authenticate() async {
    return await repository.authenticateWithBiometrics();
  }
}