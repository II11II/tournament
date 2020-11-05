part of 'sign_up_cubit.dart';

class SignUpState  {
  final NetworkState state;
  final String message;
  final bool isButtonActive;
  final bool isEmptyLoginField;
  final bool isEmptyEmailField;
  final String passwordField;
  final String confirmPasswordField;

  const SignUpState(
      {this.isEmptyLoginField = true,
      this.isEmptyEmailField = true,
      this.passwordField="",
      this.confirmPasswordField="",
      this.isButtonActive = false,
      this.message,
      this.state = NetworkState.INITIAL});

  factory SignUpState.copyWith(SignUpState signUpState,
      {bool isEmptyLoginField,
      bool isEmptyEmailField,
      String passwordField,
      String confirmPasswordField,
      bool isButtonActive,
      String message,
      NetworkState state}) {
    return SignUpState(
      state: state??signUpState.state,
      message: message??signUpState.message,
      isButtonActive: isButtonActive??signUpState.isButtonActive,
      isEmptyLoginField: isEmptyLoginField??signUpState.isEmptyLoginField,
      isEmptyEmailField: isEmptyEmailField??signUpState.isEmptyEmailField,
      passwordField: passwordField??signUpState.passwordField,
      confirmPasswordField: confirmPasswordField??signUpState.confirmPasswordField,
    );
  }

 
}
