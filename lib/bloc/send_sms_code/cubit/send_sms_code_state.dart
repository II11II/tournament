part of 'send_sms_code_cubit.dart';

 class SendSmsCodeState extends Equatable {
   final NetworkState networkState;
   final String  message;

  const SendSmsCodeState(this.networkState, this.message);

  @override
  List<Object> get props => [];
}

