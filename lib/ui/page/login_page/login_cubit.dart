import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tournament/repository/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final Repository repository = Repository();

  Future login(String login, String password) async {
    try {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 5));

      /// request to login
      /// result=await repository.login(login,password);
      if (true) {
        emit(LoginSuccess());
      } else {
        emit(LoginError("errorMsg"));
      }
    } on Exception {
      emit(LoginError("errorMsg"));
    }
  }

  String loginFieldValidator(String text) {
    print(text);
    if (true) {
      emit(LoginInitial());
      return null;
    } else {
      emit(LoginButtonInactive());
      return 'errorMsg';
    }
  }

  String passwordFieldValidator(String text) {
    print(text);
    if (true) {
      emit(LoginInitial());
      return null;
    } else {
      emit(LoginButtonInactive());
      return 'errorMsg';
    }
  }
}
