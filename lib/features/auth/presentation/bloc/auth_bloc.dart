import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/biometric_result.dart';
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
        emit(state.copyWith(message: 'Biometric authentication not supported'));
        return;
      }

      try {
        final result = await checkBiometricLogin.authenticate();
        if (result.isRight()) {
          final biometricResult = result.getOrElse(() => BiometricResult(isSupported: false, isAuthenticated: false, message: 'Unknown error'));
          if (biometricResult.isAuthenticated) {
            await prefs.setBool('isBiometricEnabled', true);
            emit(state.copyWith(isBiometricEnabled: true, message: 'Biometric login enabled'));
          } else {
            emit(state.copyWith(isBiometricEnabled: false, message: biometricResult.message));
          }
        } else {
          emit(state.copyWith(isBiometricEnabled: false, message: 'Biometric login failed'));
        }
      } catch (e) {
        emit(state.copyWith(isBiometricEnabled: false, message: 'Error: $e'));
      }
    } else {
      await prefs.setBool('isBiometricEnabled', false);
      emit(state.copyWith(isBiometricEnabled: false, message: 'Biometric login disabled'));
    }
  }


}