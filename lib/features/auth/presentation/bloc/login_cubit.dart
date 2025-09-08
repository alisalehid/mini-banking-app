import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginState {
  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final bool isValid;
  final bool isLoading;
  final String? error;
  final bool success; // New flag

  LoginState({
    this.username = '',
    this.password = '',
    this.usernameError,
    this.passwordError,
    this.isValid = false,
    this.isLoading = false,
    this.error,
    this.success = false, // Initialize to false
  });

  LoginState copyWith({
    String? username,
    String? password,
    Object? usernameError = _noChange,
    Object? passwordError = _noChange,
    bool? isValid,
    bool? isLoading,
    Object? error = _noChange,
    bool? success, // Add to copyWith
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError == _noChange ? this.usernameError : usernameError as String?,
      passwordError: passwordError == _noChange ? this.passwordError : passwordError as String?,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      error: error == _noChange ? this.error : error as String?,
      success: success ?? this.success, // Include in copyWith
    );
  }

  static const _noChange = Object();
}

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginState());

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
    final isUsernameValid = username.isNotEmpty && RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(username);
    final isPasswordValid = password.isNotEmpty && password.length >= 6;
    return isUsernameValid && isPasswordValid && usernameError == null && passwordError == null;
  }

  Future<void> login() async {
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

    emit(state.copyWith(isLoading: true, error: null, success: false));

    try {
      final success = await _loginUseCase.execute(
        state.username,
        state.password,
      );

      emit(state.copyWith(
        isLoading: false,
        error: success ? null : "Invalid credentials",
        success: success, // Set success flag
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Something went wrong",
        success: false,
      ));
    }
  }}