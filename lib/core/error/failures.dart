abstract class Failure {
  final String message;
  Failure(this.message);
}

class BiometricFailure extends Failure {
  BiometricFailure(String message) : super(message);
}