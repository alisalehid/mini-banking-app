import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SharedPreferences prefs;

  LoginCubit(this.loginUseCase, this.prefs) : super(LoginState()) {
    initialize(); // Restore login state on startup
  }

  void usernameChanged(String value) {
    String? usernameError;
    if (value.isEmpty) {
      usernameError = "Username cannot be empty";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      usernameError = "Please enter a valid email address";
    }

    final isValid = _validate(
      username: value,
      password: state.password,
      usernameError: usernameError,
      passwordError: state.passwordError,
    );

    emit(state.copyWith(
      username: value,
      usernameError: usernameError,
      isValid: isValid,
    ));
  }

  void passwordChanged(String value) {
    String? passwordError;
    if (value.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (value.length < 6) {
      passwordError = "Password must be at least 6 characters";
    }

    final isValid = _validate(
      username: state.username,
      password: value,
      usernameError: state.usernameError,
      passwordError: passwordError,
    );

    emit(state.copyWith(
      password: value,
      passwordError: passwordError,
      isValid: isValid,
    ));
  }

  bool _validate({
    required String username,
    required String password,
    String? usernameError,
    String? passwordError,
  }) {
    final isUsernameValid =
        username.isNotEmpty && RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(username);
    final isPasswordValid = password.isNotEmpty && password.length >= 6;
    return isUsernameValid && isPasswordValid && usernameError == null && passwordError == null;
  }

  Future<void> loginWithCredentials() async {
    if (!state.isValid) {
      emit(state.copyWith(
        usernameError: state.username.isEmpty ? "Username cannot be empty" : null,
        passwordError: state.password.isEmpty
            ? "Password cannot be empty"
            : state.password.length < 6
            ? "Password must be at least 6 characters"
            : null,
        isValid: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final success =
      await loginUseCase.loginWithCredentials(state.username, state.password);

      if (success) {
        await prefs.setBool('isLoggedIn', true);
        emit(state.copyWith(
          isLoading: false,
          error: null,
          success: true,        // One-time trigger
          username: '',
          password: '',
          usernameError: null,
          passwordError: null,
          isValid: false,
          isLoggedIn: true,
        ));

        // Reset success after listener triggers
        Future.microtask(() => emit(state.copyWith(success: false)));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: "Invalid credentials",
          success: false,
          isLoggedIn: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Something went wrong: $e",
        success: false,
      ));
    }
  }

  Future<void> loginWithBiometrics() async {
    final isBiometricEnabled = prefs.getBool('isBiometricEnabled') ?? false;
    if (!isBiometricEnabled) {
      emit(state.copyWith(error: 'Biometric login is not enabled', success: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    final result = await loginUseCase.loginWithBiometrics();
    result.fold(
          (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message, success: false));
      },
          (biometricResult) async {
        if (biometricResult.isAuthenticated) {
          await prefs.setBool('isLoggedIn', true);
          emit(state.copyWith(
            isLoading: false,
            error: null,
            success: true,
            username: '',
            password: '',
            usernameError: null,
            passwordError: null,
            isValid: false,
            isLoggedIn: true,
          ));

          Future.microtask(() => emit(state.copyWith(success: false)));
        } else {
          emit(state.copyWith(
            isLoading: false,
            error: biometricResult.message ?? 'Biometric authentication failed',
            success: false,
          ));
        }
      },
    );
  }

  void initialize() async {
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    emit(state.copyWith(isLoggedIn: loggedIn));
  }

  Future<void> logout() async {
    await prefs.setBool('isLoggedIn', false);
    emit(state.copyWith(
      isLoggedIn: false,
      success: false,
      username: '',
      password: '',
      usernameError: null,
      passwordError: null,
      isValid: false,
      error: null,
    ));
  }
}
