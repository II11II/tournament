import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/tournament.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  var log = Logger();
  final Repository repository = Repository.instance;

  Future logout() async {
    try {
      await repository.removeUserToken();
      // await repository.logout();

      emit(state.copyWith(logout: true));
    } on ServerErrorException {
      emit(state.copyWith(logout: false));
    } on Exception {
      emit(state.copyWith(logout: false));
    }
  }

  Future<List<Tournament>> getPremiumTournaments() async {
    List<Tournament> premiumTournaments = await repository.premiumTournaments();
    return premiumTournaments..sort((a,b)=>a.createdAt.compareTo(b.createdAt));
  }

  Future<List<Tournament>> getTodayTournaments() async {
    List<Tournament> todayTournaments = await repository.todayTournaments();
    return todayTournaments..sort((a,b)=>a.createdAt.compareTo(b.createdAt));
  }

  Future<List<Tournament>> getUpcomingTournaments() async {
    List<Tournament> upcomingTournaments =
        await repository.upcomingTournaments();
    return upcomingTournaments..sort((a,b)=>a.createdAt.compareTo(b.createdAt));
  }

  Future init() async {
    emit(state.copyWith(networkState: NetworkState.LOADING));
    try {
      emit(state.copyWith(
          networkState: NetworkState.LOADED,
          todayTournaments: await getTodayTournaments(),
          upcomingTournaments: await getUpcomingTournaments(),
          premiumTournaments: await getPremiumTournaments()));
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
