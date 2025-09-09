import 'package:local_auth/local_auth.dart';
import '../models/biometric_result.dart';

abstract class BiometricDataSource {
  Future<BiometricResultModel> checkBiometricSupport();
  Future<BiometricResultModel> authenticateWithBiometrics();
}

class BiometricDataSourceImpl implements BiometricDataSource {
  final LocalAuthentication localAuth;
  BiometricDataSourceImpl(this.localAuth);

  @override
  Future<BiometricResultModel> checkBiometricSupport() async {
    try {
      final isDeviceSupported = await localAuth.isDeviceSupported();
      final canCheckBiometrics = await localAuth.canCheckBiometrics;
      final available = await localAuth.getAvailableBiometrics();

      final supportsFingerprint = available.contains(BiometricType.fingerprint);
      final supportsAnyBiometric = available.isNotEmpty;

      return BiometricResultModel(
        isSupported: isDeviceSupported && canCheckBiometrics && supportsAnyBiometric,
        isAuthenticated: false,
        message: (isDeviceSupported && canCheckBiometrics && supportsAnyBiometric)
            ? 'Biometric support available'
            : 'Biometric not supported',
      );
    } catch (e) {
      return BiometricResultModel(
        isSupported: false,
        isAuthenticated: false,
        message: 'Failed to check biometric support: $e',
      );
    }
  }

  @override
  Future<BiometricResultModel> authenticateWithBiometrics() async {
    try {
      final available = await localAuth.getAvailableBiometrics();

      if (available.isEmpty) {
        return BiometricResultModel(
          isSupported: false,
          isAuthenticated: false,
          message: 'No biometrics available on device',
        );
      }

      final authenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to enable biometric login',
        options: AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      return BiometricResultModel(
        isSupported: true,
        isAuthenticated: authenticated,
        message: authenticated ? 'Authentication successful' : 'Authentication failed',
      );
    } catch (e) {
      return BiometricResultModel(
        isSupported: false,
        isAuthenticated: false,
        message: 'Biometric authentication failed: $e',
      );
    }
  }
}
