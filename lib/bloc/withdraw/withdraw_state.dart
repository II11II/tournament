part of 'withdraw_bloc.dart';

@immutable
abstract class WithdrawState extends Equatable{}

class WithdrawInitial extends WithdrawState {
  @override

  List<Object> get props => [];
}
class WithdrawLoading extends WithdrawState {
  @override

  List<Object> get props => [];
}
class WithdrawLoaded extends WithdrawState {
  @override

  List<Object> get props => [];
}class WithdrawError extends WithdrawState {
  final String message;

  WithdrawError(this.message);
  @override

  List<Object> get props => [message];
}
