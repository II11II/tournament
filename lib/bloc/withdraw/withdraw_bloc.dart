import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:easy_localization/easy_localization.dart';

part 'withdraw_event.dart';

part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawBloc(this._repository) : super(WithdrawInitial());
  final log = Logger();
  final Repository _repository;

  @override
  Stream<WithdrawState> mapEventToState(
    WithdrawEvent event,
  ) async* {
    if (event is Withdraw) {
      yield WithdrawLoading();
      try {
        await _repository.withdraw(event.card, event.holder, event.amount);
        yield WithdrawLoaded();

      } on ServerErrorException catch (e) {
        yield WithdrawError("server_error".tr());

        log.d(e);
      } on InvalidCardCredentialsException catch (e) {
        yield WithdrawError("invalid_card_credentials".tr());

        log.d(e);
      } on InvalidTokenException catch (e) {
        await _repository.removeUserToken();
        yield WithdrawError("invalid_token".tr());

        log.d(e);
      } on SocketException catch (e) {
        yield WithdrawError("no_connection".tr());

        log.d(e);
      } on Exception catch (e) {
        yield WithdrawError("unknown_error".tr());

        log.d(e);
      }
    }
  }
}
