part of 'forget_password_cubit.dart';

class ForgetPasswordState {
  bool isButtonActive = false;
  bool isActivePassField = false;
  NetworkState state = NetworkState.INITIAL;
  String message;
  ForgetPasswordState(
      {this.isButtonActive = false,
      this.message,
      this.isActivePassField = false,
      this.state});
  factory ForgetPasswordState.copyWith(ForgetPasswordState forgetPasswordState,
      {bool isActivePassField,
      bool isButtonActive,
      String message,
      NetworkState state}) {
    return ForgetPasswordState(
      isActivePassField:
          isActivePassField ?? forgetPasswordState.isActivePassField,
      state: state ?? forgetPasswordState.state,
      message: message ?? forgetPasswordState.message,
      isButtonActive: isButtonActive ?? forgetPasswordState.isButtonActive,
    );
  }
}
