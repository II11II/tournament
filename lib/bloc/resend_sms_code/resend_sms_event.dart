part of 'resend_sms_bloc.dart';

@immutable
abstract class ResendSmsEvent {}

class ResentSmsEvent extends ResendSmsEvent {
  final String cardToken;

  ResentSmsEvent(this.cardToken);
}
