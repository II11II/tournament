import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/tournament.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(Tournament tournament) : super(MatchState(tournament));
  final Repository repository = Repository.instance;
  var log = Logger();
  void expandInstruction()=>
    emit(state.copyWith(isInstructionExpanded:!state.isInstructionExpanded ));

  void expandDescription() =>
      emit(state.copyWith(isDescriptionExpanded: !state.isDescriptionExpanded));



  likePress() async {
    try {
      emit(state.copyWith(networkState: NetworkState.LOADING));
      await repository.toFavourite(state.tournament.id);

      emit(state.copyWith(networkState: NetworkState.LOADED,isLiked:!state.isLiked ));

    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          networkState: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(),
          networkState: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(),
          networkState: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown_error".tr(),
          networkState: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
