abstract class AuthEvent {}

class CheckBiometricSupport extends AuthEvent {}

class ToggleBiometricLogin extends AuthEvent {
  final bool enable;
  ToggleBiometricLogin(this.enable);
}