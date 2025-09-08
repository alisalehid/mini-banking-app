class AuthState {
  final bool isBiometricSupported;
  final bool isBiometricEnabled;
  final String? message;

  AuthState({
    required this.isBiometricSupported,
    required this.isBiometricEnabled,
    this.message,
  });

  AuthState copyWith({
    bool? isBiometricSupported,
    bool? isBiometricEnabled,
    String? message,
  }) {
    return AuthState(
      isBiometricSupported: isBiometricSupported ?? this.isBiometricSupported,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      message: message,
    );
  }
}