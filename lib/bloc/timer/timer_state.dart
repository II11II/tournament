import 'package:equatable/equatable.dart';
import 'package:tournament/ui/state/network_state.dart';

abstract class TimerState extends Equatable {
  final NetworkState networkState;
  final String smsCode;

  final int duration;
  final String error;
  const TimerState(
      {this.error,
      this.networkState = NetworkState.INITIAL,
      this.smsCode,
      this.duration});



  @override
  List<Object> get props => [duration, networkState, smsCode, error];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration: duration,);

 
  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration:duration);
 

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(duration: 0);
}
