class MockAuthRepository {
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    return username == "user@test.com" && password == "123456";
  }
}
