import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/bloc/send_sms_code/cubit/send_sms_code_cubit.dart';
import 'package:tournament/bloc/timer/timer.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';

class SmsCodeVerifaction extends StatefulWidget {
  final MatchCubit bloc;

  const SmsCodeVerifaction( this.bloc) ;
  @override
  _SmsCodeVerifactionState createState() => _SmsCodeVerifactionState();
}

class _SmsCodeVerifactionState extends State<SmsCodeVerifaction> {
  @override
  void initState() {
    print(widget.bloc.state.card.result.wait ~/ 100);
    context.read<TimerBloc>().add(TimerStarted(
        duration: widget.bloc.state.card.result.wait ~/ 100));
    super.initState();
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<SendSmsCodeCubit>();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
            
              final String minutesStr = ((state.duration/100 / 60) % 60)
                  .floor()
                  .toString()
                  .padLeft(2, '0');
              final String secondsStr =
                  (state.duration % 60).floor().toString().padLeft(2, '0');
              return Text(
                "$minutesStr:$secondsStr",
                style: TextStyle(color: Colors.white),
              );
            },
          ),
          CustomTextField(
            controller: controller,
          ),
          CustomButton(
              text: "send".tr(),
              onPressed: () => cubit.checkSmsCode(controller.text))
        ],
      ),
    );
  }
}
