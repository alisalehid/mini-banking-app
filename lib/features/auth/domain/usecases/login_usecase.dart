import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/biometric_result.dart';
import '../repositories/auth_repository.dart';
import '../../data/repositories/mock_auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository; // For biometrics
  final MockAuthRepository mockRepository; // For username/password

  LoginUseCase(this.authRepository, this.mockRepository);

  Future<bool> loginWithCredentials(String username, String password) async {
    return await mockRepository.login(username, password);
  }

  Future<Either<Failure, BiometricResult>> loginWithBiometrics() async {
    return await authRepository.authenticateWithBiometrics();
  }
}