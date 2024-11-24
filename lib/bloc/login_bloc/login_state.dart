part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


class AuthState extends LoginState{
  final String? token;
  final bool isAuthenticated;

  AuthState({this.token, this.isAuthenticated = false});

}


class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String? emailError;
  final String? passwordError;
  final String? generalError;

  LoginFailure({this.emailError, this.passwordError, this.generalError});

  String get errorMessage => generalError ?? 'Đăng nhập thất bại';
}
class LogoutInitial extends LoginState {}

class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {}

class LogoutFailure extends LoginState {
  final String error;

  LogoutFailure({required this.error});

  @override
  List<Object> get props => [error];
}