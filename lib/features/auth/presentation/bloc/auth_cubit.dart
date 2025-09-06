import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  bool get isAuthenticated => this is Authenticated;

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const Unauthenticated());

  void login() {
    emit(const Authenticated());
  }

  void logout() {
    emit(const Unauthenticated());
  }
}
