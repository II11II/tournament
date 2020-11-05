part of 'login_cubit.dart';

class LoginState {
  final String message;

  final bool isButtonActive;
  final NetworkState networkState;
  LoginState(
      {this.networkState = NetworkState.INITIAL,
     
      this.message,
      this.isButtonActive = false});
  factory LoginState.copyWith(LoginState loginState,
      {bool isButtonActive, String message, NetworkState networkState}) {
    return LoginState(
      message: message ?? loginState.message,
      networkState: networkState ?? loginState.networkState,
      isButtonActive: isButtonActive ?? loginState.isButtonActive,
    );
  }
}
