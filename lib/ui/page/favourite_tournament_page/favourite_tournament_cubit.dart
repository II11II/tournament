import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/favourite.dart';
import 'package:tournament/model/tournament.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'favourite_tournament_state.dart';

class FavouriteTournamentCubit extends Cubit<FavouriteTournamentState> {
  FavouriteTournamentCubit() : super(FavouriteTournamentState());
  final Repository _repository = Repository.instance;
  var log = Logger();

  init() async {
    try {
      emit(state.copyWith(networkState: NetworkState.LOADING));
      var favouritesTournaments = await _repository.favouritesTournaments();
      emit(state.copyWith(
          networkState: NetworkState.LOADED,
          favouriteTournaments: favouritesTournaments));
    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          networkState: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await _repository.removeUserToken();
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
          message: "unknown_error".tr(), networkState: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
  likePress(int id) async {
    try {
      _repository.toFavourite(id);
    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          networkState: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await _repository.removeUserToken();
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
          message: "unknown_error".tr(), networkState: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
