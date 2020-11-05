import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordState());
  final Repository repo = Repository.instance;
  final loginField = TextEditingController();
  final passwordField = TextEditingController();

  Future recoverPasswordByEmail(String email) async {
    try {
      emit(ForgetPasswordState.copyWith(state, state: NetworkState.LOADING));
      throw InvalidCodeException();
      await repo.resetPassword(email);
    } on InvalidTokenException catch (e) {
      emit(ForgetPasswordState.copyWith(state, state: NetworkState.INVALID_TOKEN));
    } on ServerErrorException catch (e) {
      emit(ForgetPasswordState.copyWith(state, state: NetworkState.SERVER_ERROR));
    } on Exception catch (e) {
      emit(ForgetPasswordState.copyWith(state, state: NetworkState.NO_CONNECTION));
    }
  }

  Future nextButton() async {
    if (!state.isActivePassField) {
      recoverPasswordByEmail(loginField.text);
      // emit(ForgetPasswordState.copyWith(showP,astate:sField=true);
    } else {
      
    }
  }

  String loginValidator(String text) {
    if (text.contains(RegExp(
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false,
        multiLine: false))) {
      emit(ForgetPasswordState.copyWith(state, isButtonActive: true));

      return null;
    } else {
      emit(ForgetPasswordState.copyWith(state, isButtonActive: false));
      return 'email_validation_info'.tr();
    }
  }
}
