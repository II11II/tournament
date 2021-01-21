import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

part 'resend_sms_event.dart';

part 'resend_sms_state.dart';

class ResendSmsBloc extends Bloc<ResendSmsEvent, ResendSmsState> {
  ResendSmsBloc() : super(ResendSmsInitial());
  final Repository _repository = Repository.instance;
  final log = Logger();

  @override
  Stream<ResendSmsState> mapEventToState(
    ResendSmsEvent event,
  ) async* {
    if (event is ResentSmsEvent) yield* resentSmsEvent(event);
  }

  Stream<ResendSmsState> resentSmsEvent(ResentSmsEvent event) async* {
    yield ResendSmsLoading();
    try {
      await _repository.resendSmsCode(event.cardToken);
      yield ResendSmsLoaded();
    } on ServerErrorException catch (e) {
      yield ResendSmsError("server_error".tr());

      log.d(e);
    } on InvalidCardCredentialsException catch (e) {
      yield ResendSmsError("invalid_card_credentials".tr());

      log.d(e);
    } on InvalidTokenException catch (e) {
      await _repository.removeUserToken();
      yield ResendSmsError("invalid_token".tr());

      log.d(e);
    } on SocketException catch (e) {
      yield ResendSmsError("no_connection".tr());

      log.d(e);
    } on Exception catch (e) {
      yield ResendSmsError("unknown_error".tr());

      log.d(e);
    }
  }
}
