import 'package:local_auth/local_auth.dart';
import '../../../../core/error/exceptions.dart';
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
      final isSupported = isDeviceSupported && canCheckBiometrics;
      return BiometricResultModel(
        isSupported: isSupported,
        isAuthenticated: false,
        message: isSupported ? 'Biometric support available' : 'Biometric not supported',
      );
    } catch (e) {
      throw BiometricException('Failed to check biometric support: $e');
    }
  }

  @override
  Future<BiometricResultModel> authenticateWithBiometrics() async {
    try {
      final isDeviceSupported = await localAuth.isDeviceSupported();
      final canCheckBiometrics = await localAuth.canCheckBiometrics;
      final isSupported = isDeviceSupported && canCheckBiometrics;

      if (!isSupported) {
        return BiometricResultModel(
          isSupported: false,
          isAuthenticated: false,
          message: 'Biometric not supported on this device',
        );
      }

      final authenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to enable biometric login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return BiometricResultModel(
        isSupported: isSupported,
        isAuthenticated: authenticated,
        message: authenticated ? 'Authentication successful' : 'Authentication failed',
      );
    } catch (e) {
      throw BiometricException('Biometric authentication failed: $e');
    }
  }
}