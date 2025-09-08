class BiometricResult {
  final bool isSupported;
  final bool isAuthenticated;
  final String message;

  const BiometricResult({
    required this.isSupported,
    required this.isAuthenticated,
    required this.message,
  });
}