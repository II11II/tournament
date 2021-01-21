part of 'sign_up_cubit.dart';

class SignUpState  {
  final NetworkState state;
  final String message;
  final bool isButtonActive;
  final bool isEmptyLoginField;
  final bool isEmptyNameField;
  final bool isEmptyPubgField;
  final String passwordField;
  final String confirmPasswordField;

  const SignUpState(
      {this.isEmptyLoginField = true,
        this.isEmptyNameField=true,
        this.isEmptyPubgField = true,
      this.passwordField="",
      this.confirmPasswordField="",
      this.isButtonActive = false,
      this.message,
      this.state = NetworkState.INITIAL});

  factory SignUpState.copyWith(SignUpState signUpState,
      {bool isEmptyLoginField,
        bool isEmptyNameField,
        bool isEmptyPubgField,
      String passwordField,
      String confirmPasswordField,
      bool isButtonActive,
      String message,
      NetworkState state}) {
    return SignUpState(
      isEmptyNameField: isEmptyNameField??signUpState.isEmptyNameField,
      state: state??signUpState.state,
      message: message??signUpState.message,
      isButtonActive: isButtonActive??signUpState.isButtonActive,
      isEmptyLoginField: isEmptyLoginField??signUpState.isEmptyLoginField,
      isEmptyPubgField: isEmptyPubgField??signUpState.isEmptyPubgField,
      passwordField: passwordField??signUpState.passwordField,
      confirmPasswordField: confirmPasswordField??signUpState.confirmPasswordField,
    );
  }

 
}
