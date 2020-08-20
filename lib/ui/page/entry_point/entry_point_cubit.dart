import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tournament/repository/repository.dart';

part 'entry_point_state.dart';

class EntryPointCubit extends Cubit<EntryPointState> {
  EntryPointCubit() : super(EntryPointSplash());
  final Repository repository = Repository();

  Future getScreen() async {
    await Future.delayed(Duration(seconds: 1,milliseconds: 500,));
    try {
      String userToken = await repository.getUserToken;
      if (userToken == null)
        emit(EntryPointNotAuthenticated());
      else
        emit(EntryPointAuthenticated());
    } on Exception {
      emit(EntryPointNotAuthenticated());
    }
  }
}