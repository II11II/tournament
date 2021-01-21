import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tournament/bloc/timer/timer_event.dart';
import 'package:tournament/bloc/timer/timer_state.dart';
import 'package:tournament/exception/exception.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';

class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc(Ticker ticker)
      : assert(ticker != null ),
        _ticker = ticker,

        super(TimerInitial(0));

  StreamSubscription<int> _tickerSubscription;
  final Ticker _ticker;

  final log = Logger();

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    print(tick);
    yield tick.duration > 0
        ? TimerRunInProgress(tick.duration)
        : TimerRunComplete();
  }





  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
