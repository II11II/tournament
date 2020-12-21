import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'send_sms_code_state.dart';

class SendSmsCodeCubit extends Cubit<SendSmsCodeState> {
  SendSmsCodeCubit(MatchCubit cubit, Repository repository)
      : _cubit = cubit,
        _repository = repository,
        super(SendSmsCodeState(NetworkState.INITIAL, null));
  final Repository _repository;
  final MatchCubit _cubit;
  final log=Logger();
  Future checkSmsCode(String smsCode) async {
    try {
      await _repository.checkSmsCode(
        smsCode, _cubit.state.card.token, _cubit.state.amount);
    } on ServerErrorException catch (e) {
      emit( SendSmsCodeState(NetworkState.SERVER_ERROR,
          "server_error".tr() ));

      log.d(e);
    } on InvalidCardCredentialsException catch (e) {
      emit( SendSmsCodeState(NetworkState.INVALID_CREDENTIALS,
          "invalid_card_credentials".tr() ));
     

      log.d(e);
    } on InvalidTokenException catch (e) {
      await _repository.removeUserToken();
       emit( SendSmsCodeState(NetworkState.INVALID_TOKEN,
          "invalid_token".tr() ));
      

      log.d(e);
    } on SocketException catch (e) {
      emit( SendSmsCodeState(NetworkState.NO_CONNECTION,
          "no_connection".tr() ));
      
   

      log.d(e);
    } on Exception catch (e) {
            emit( SendSmsCodeState(NetworkState.UNKNOWN_ERROR,
          "unknown_error".tr() ));
     

      log.d(e);
    }
  }
}
