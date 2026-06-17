part of 'login_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoadedLogin extends AuthState {
  final LoginResponse response;

  AuthLoadedLogin(this.response);
}

class AuthLoadedRegister extends AuthState {
  final RegisterResponse response;
  AuthLoadedRegister(this.response);
}

// class AuthLoadedOtp extends AuthState {
//   final ActivationResponse response;
//   AuthLoadedOtp(this.response);
// }
