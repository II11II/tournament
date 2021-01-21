import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/player.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  final Repository repository = Repository.instance;
  final log = Logger();

  Future init() async {
    try {
      emit(state.copyWith(
        state: NetworkState.LOADING,
      ));
      Player profile = await repository.player();
      log.d(profile);
      emit(state.copyWith(state: NetworkState.LOADED, player: profile));
    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(), state: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(), state: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(), state: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown".tr(), state: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }

}
