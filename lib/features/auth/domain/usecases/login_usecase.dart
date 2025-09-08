import '../../data/repositories/mock_auth_repository.dart';

class LoginUseCase {
  final MockAuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(String username, String password) {
    return repository.login(username, password);
  }
}
