import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/bloc/resend_sms_code/resend_sms_bloc.dart';
import 'package:tournament/bloc/send_sms_code/cubit/send_sms_code_cubit.dart';
import 'package:tournament/bloc/timer/timer.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class SmsCodeVerification extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<SendSmsCodeCubit>();
    var resendSmsBloc = context.watch<ResendSmsBloc>();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              if (state is TimerRunComplete)
                return FlatButton(
                    onPressed: () {
                      resendSmsBloc.add(ResentSmsEvent(
                          context.bloc<MatchCubit>().state.card.token));
                    },
                    child: Text(
                      "resend_sms_code".tr(),
                      style: TextStyle(color: Colors.white),
                    ));
              else if (state is TimerRunInProgress) {
                final String minutesStr = ((state.duration / 100 / 60) % 60)
                    .floor()
                    .toString()
                    .padLeft(2, '0');
                final String secondsStr =
                    (state.duration % 60).floor().toString().padLeft(2, '0');

                return Text(
                  "$minutesStr:$secondsStr",
                  style: TextStyle(color: Colors.white),
                );
              } else
                return Text(
                  "$state:$state",
                  style: TextStyle(color: Colors.white),
                );
            },
          ),
          CustomTextField(
            controller: controller,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6)
            ],
          ),
          BlocListener<SendSmsCodeCubit, SendSmsCodeState>(
            listener: (context, state) {
              if (state.networkState == NetworkState.LOADED) {
                Navigator.of(context,rootNavigator: true).pop();
                showMessage(
                    context, "${state.message}", Icons.check_circle_outline,
                    iconColor: Colors.greenAccent);
              } else if (state.networkState == NetworkState.LOADING)
                showLoading(context);
              else {
                Navigator.of(context,rootNavigator: true).pop();

                showMessage(
                    context, "${state.message}", Icons.warning_amber_outlined,
                    iconColor: Colors.redAccent);
              }
            },
            child: CustomButton(
                text: "send".tr(),
                onPressed: () => cubit.checkSmsCode(controller.text)),
          )
        ],
      ),
    );
  }
}
