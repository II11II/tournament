import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future register(String nick, String password, String email) async {
    try {
      emit(SignUpLoading());
      await Future.delayed(Duration(seconds: 5));

      /// request to login
      /// result=await repository.register(nick,email,password);
      if (true) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpError("errorMsg"));
      }
    } on Exception {
      emit(SignUpError("errorMsg"));
    }
  }

  String passwordFieldValidator(String text) {
    print(text);
    if (true) {
      emit(SignUpInitial());
      return null;
    } else {
      emit(SignUpButtonInactive());
      return 'errorMsg';
    }
  }

  String passwordConfirmFieldValidator(String text) {
    print(text);
    if (true) {
      emit(SignUpInitial());
      return null;
    } else {
      emit(SignUpButtonInactive());
      return 'errorMsg';
    }
  }

  String loginFieldValidator(String text) {
    if (true) {
      emit(SignUpInitial());
      return null;
    } else {
      emit(SignUpButtonInactive());
      return 'errorMsg';
    }
  }

  String emailFieldValidator(String text) {
    if (true) {
      emit(SignUpInitial());
      return null;
    } else {
      emit(SignUpButtonInactive());
      return 'errorMsg';
    }
  }
}
