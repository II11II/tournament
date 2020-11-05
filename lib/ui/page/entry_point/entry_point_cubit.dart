import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:tournament/repository/repository.dart';

part 'entry_point_state.dart';

class EntryPointCubit extends Cubit<EntryPointState> {
  EntryPointCubit() : super(EntryPointSplash());
  final Repository repository = Repository.instance;


  Future getScreen() async {

    try {
      await Future.delayed(Duration(seconds: 1,milliseconds: 500,));
      String userToken = await repository.getUserToken();
      Logger().d("TOKEN:$userToken");
      if (userToken == null)
        emit(EntryPointNotAuthenticated());
      else
        emit(EntryPointAuthenticated());
    } on Exception catch(e) {

      emit(EntryPointNotAuthenticated());
    }
  }
}