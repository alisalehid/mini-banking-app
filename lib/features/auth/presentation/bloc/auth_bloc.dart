import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/check_biometric_login.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckBiometricLogin checkBiometricLogin;
  final SharedPreferences prefs;

  AuthBloc(this.checkBiometricLogin, this.prefs)
      : super(AuthState(isBiometricSupported: false, isBiometricEnabled: false)) {
    on<CheckBiometricSupport>(_onCheckBiometricSupport);
    on<ToggleBiometricLogin>(_onToggleBiometricLogin);
    _loadInitialBiometricState();
  }

  Future<void> _loadInitialBiometricState() async {
    final isBiometricEnabled = prefs.getBool('isBiometricEnabled') ?? false;
    emit(state.copyWith(isBiometricEnabled: isBiometricEnabled));
    add(CheckBiometricSupport());
  }

  Future<void> _onCheckBiometricSupport(
      CheckBiometricSupport event, Emitter<AuthState> emit) async {
    final result = await checkBiometricLogin.checkSupport();
    result.fold(
          (failure) => emit(state.copyWith(message: failure.message)),
          (biometricResult) => emit(state.copyWith(
        isBiometricSupported: biometricResult.isSupported,
        message: biometricResult.message,
      )),
    );
  }

  Future<void> _onToggleBiometricLogin(
      ToggleBiometricLogin event, Emitter<AuthState> emit) async {
    if (event.enable) {
      if (!state.isBiometricSupported) {
        emit(state.copyWith(
            message: 'Biometric authentication is not supported on this device'));
        return;
      }

      final result = await checkBiometricLogin.authenticate();
      result.fold(
            (failure) => emit(state.copyWith(
            message: failure.message, isBiometricEnabled: false)),
            (biometricResult) {
          if (biometricResult.isAuthenticated) {
            prefs.setBool('isBiometricEnabled', true);
            emit(state.copyWith(
                isBiometricEnabled: true, message: biometricResult.message));
          } else {
            prefs.setBool('isBiometricEnabled', false);
            emit(state.copyWith(
                isBiometricEnabled: false, message: biometricResult.message));
          }
        },
      );
    } else {
      await prefs.setBool('isBiometricEnabled', false);
      emit(state.copyWith(
          isBiometricEnabled: false, message: 'Biometric login disabled'));
    }
  }
}