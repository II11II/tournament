part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String errorMsg;

  const LoginError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class LoginButtonInactive extends LoginState {
  const LoginButtonInactive();

  @override
  List<Object> get props => [];
}
