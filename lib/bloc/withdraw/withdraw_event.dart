part of 'withdraw_bloc.dart';

@immutable
abstract class WithdrawEvent {

  const WithdrawEvent();
}

class Withdraw extends WithdrawEvent {
  final String card;
  final String holder;
  final String amount;

 const Withdraw(this.card, this.holder, this.amount);
}
