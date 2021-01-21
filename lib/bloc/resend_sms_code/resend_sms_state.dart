part of 'resend_sms_bloc.dart';

@immutable
abstract class ResendSmsState extends Equatable {
  const ResendSmsState();
}

class ResendSmsInitial extends ResendSmsState {
  @override
  List<Object> get props => const [];
}

class ResendSmsLoading extends ResendSmsState {
  @override
  List<Object> get props => const [];
}

class ResendSmsLoaded extends ResendSmsState {
  @override
  List<Object> get props => const [];
}

class ResendSmsError extends ResendSmsState {
  final String message;

  const ResendSmsError(this.message);

  @override
  List<Object> get props => [message];
}
