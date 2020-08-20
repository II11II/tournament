part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();

  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();

  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();

  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  final String errorMsg;
  const SignUpError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
class SignUpButtonInactive extends SignUpState {
  const SignUpButtonInactive();

  @override
  List<Object> get props => [];
}

