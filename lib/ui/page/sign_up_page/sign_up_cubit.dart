import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());
  final Repository repo = Repository.instance;
final log=Logger();
  Future register(String phone, String password, String pubgId,String fullName) async {

    try {
      emit(SignUpState.copyWith(
        state,
        state: NetworkState.LOADING,
      ));
     String token= await repo.registration(phone,  password,pubgId,fullName);
      await repo.setUserToken(token);
      emit(SignUpState.copyWith(
        state,
        state: NetworkState.LOADED,
      ));
    } on UserExistException catch (e) {
      emit(SignUpState.copyWith(
        state,
        message: "user_exist".tr(),
        state: NetworkState.USER_EXISTENCE,
      ));
      log.d(e);

    } on ServerErrorException catch (e) {
      emit(SignUpState.copyWith(state,
          message: "server_error".tr(), state: NetworkState.SERVER_ERROR));
      log.d(e);
    } on SocketException catch (e) {
      emit(SignUpState.copyWith(state,
          message: "no_connection".tr(), state: NetworkState.NO_CONNECTION));
    } on Exception catch (e) {
      emit(SignUpState.copyWith(state,
          message: "unknown_error".tr(), state: NetworkState.UNKNOWN_ERROR));
    }
  }

  String passwordFieldValidator(String password) {
    emit(SignUpState.copyWith(
      state,
      passwordField: password,
    ));
    button();
    if (RegExp(r'^(?=.*?[A-Z])').hasMatch(
        password)) if (RegExp(r'^(?=.*?[a-z])').hasMatch(password)) if (RegExp(
            r'^(?=.*?[0-9])')
        .hasMatch(password)) if (RegExp(r'^.{8,}$').hasMatch(password))
      return null;
    else
      return 'password_validation_info.length'.tr();
    else
      return 'password_validation_info.number'.tr();
    else
      return 'password_validation_info.small_letter'.tr();
    else
      return 'password_validation_info.capital_letter'.tr();
  }

  String passwordConfirmFieldValidator(String text) {
    if (text == state.passwordField) {
      emit(SignUpState.copyWith(state, confirmPasswordField: text));
      button();
      return null;
    } else {
      emit(SignUpState.copyWith(state, confirmPasswordField: text));
      button();
      return 'password_not_matching'.tr();
    }
  }

  String loginFieldValidator(String text) {
    if (text.isNotEmpty) {
      emit(SignUpState.copyWith(state, isEmptyLoginField: false));
      button();
      return null;
    } else {
      emit(SignUpState.copyWith(state, isEmptyLoginField: true));
      button();
      return 'login_validation_info.length'.tr();
    }
  }

  String pubgFieldValidator(String text) {
    if (text.isNotEmpty) {
      emit(SignUpState.copyWith(state, isEmptyPubgField: false));
      button();
      return null;
    } else {
      emit(SignUpState.copyWith(state, isEmptyPubgField: true));
      button();
      return 'email_validation_info'.tr();
    }
  }

  void button() {
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
            .hasMatch(state.passwordField) &&
        state.passwordField == state.confirmPasswordField &&
        !state.isEmptyPubgField &&
        !state.isEmptyNameField &&
        !state.isEmptyLoginField) {


      if (!state.isButtonActive)
        emit(SignUpState.copyWith(state, isButtonActive: true));
    } else {

      if (state.isButtonActive)
        emit(SignUpState.copyWith(state, isButtonActive: false));
    }
  }

  String nameValidator(String text) {
    if (text.isNotEmpty) {
      emit(SignUpState.copyWith(state, isEmptyNameField: false));
      button();
      return null;
    } else {
      emit(SignUpState.copyWith(state, isEmptyNameField: true));
      button();
      return 'name_validator'.tr();
    }
  }
}
