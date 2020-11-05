import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/model/ticket.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'my_tickets_state.dart';

class MyTicketsCubit extends Cubit<MyTicketsState> {
  MyTicketsCubit() : super(MyTicketsState());
  final Repository repository = Repository.instance;
  final log=Logger();
  Future getMyTickets() async {
    try {
      emit(state.copyWith(state: NetworkState.LOADING));
      List<Ticket> tickets = await repository.tickets();
      emit(state.copyWith(state: NetworkState.LOADED,myTickets: tickets));

    }
    on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          state: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(),
          state: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(),
          state: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown".tr(), state: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
