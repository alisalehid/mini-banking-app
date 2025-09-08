class LoginState {
  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final bool isValid;
  final bool isLoading;
  final String? error;
  final bool success;      // One-time trigger
  final bool isLoggedIn;   // Persistent login state

  LoginState({
    this.username = '',
    this.password = '',
    this.usernameError,
    this.passwordError,
    this.isValid = false,
    this.isLoading = false,
    this.error,
    this.success = false,
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
    bool? isValid,
    bool? isLoading,
    String? error,
    bool? success,
    bool? isLoggedIn,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError,
      passwordError: passwordError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? false,  // Reset success unless explicitly set
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
