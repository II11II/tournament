import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/bloc/resend_sms_code/resend_sms_bloc.dart';
import 'package:tournament/bloc/send_sms_code/cubit/send_sms_code_cubit.dart';
import 'package:tournament/bloc/timer/timer_bloc.dart';
import 'package:tournament/bloc/timer/timer_event.dart';
import 'package:tournament/repository/repository.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/style/style.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:tournament/ui/widget/sms_code_verifaction.dart';

showLoading(BuildContext context) async {
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Center(child: CircularProgressIndicator()),
      ));
}

showMessage(BuildContext context, String title, IconData iconData,
    {Color iconColor, Function onPressed}) async {
  await showDialog(
      context: context,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.grey.shade200),
              ),
            )
          ],
        ),
        children: [
          CustomButton(
            text: 'OK',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              onPressed();
            },
          )
        ],
      ));
}

showTicket(
    BuildContext context, String matchId, String password, String instruction,
    {Function onPressed}) async {
  await showDialog(
      context: context,
      child: SimpleDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Center(
            child: Text(
          "match_ticket".tr(),
          style: Style.bodyText2,
        )),
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                      text: "${"match_id".tr()}:",
                      style: Style.defaultText,
                      children: [
                        TextSpan(
                          text: " $matchId",
                          style: Style.smallText,
                        )
                      ]),
                ),
                Text.rich(
                  TextSpan(
                      text: "${"password".tr()}:",
                      style: Style.defaultText,
                      children: [
                        TextSpan(
                          text: " $password",
                          style: Style.smallText,
                        )
                      ]),
                ),
                Text.rich(
                  TextSpan(
                      text: "${"match_instructions".tr()}:",
                      style: Style.defaultText,
                      children: [
                        TextSpan(
                          text: " $instruction",
                          style: Style.smallText,
                        )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomButton(
            text: 'OK',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              onPressed();
            },
          )
        ],
      ));
}

showWithdraw(BuildContext context,
    {bool lock,
    @required TextEditingController card,
    @required TextEditingController amount,
    @required TextEditingController holder,
    Function onPressed}) async {
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(lock ?? true),
        child: SimpleDialog(
          title: Text(
            "withdraw_info".tr(),
            textAlign: TextAlign.center,
            style: Style.bodyText2,
          ),
          titlePadding: EdgeInsets.only(top: 21, left: 8, right: 8),
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "card_id".tr(),
                    ),
                  ),
                  CustomTextField(
                    hintText: "8600 **** **** ****",
                    controller: card,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("card_holder".tr()),
                  ),
                  CustomTextField(
                    hintText: "JOHN DOE",
                    controller: holder,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("withdraw_amount".tr()),
                  ),
                  CustomTextField(
                    hintText: "MIN. UZS 5000",
                    controller: amount,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
            CustomButton(
              title: Text(
                "withdraw".tr(),
                style: Style.defaultText,
              ),
              onPressed: onPressed,
              width: double.infinity,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ));
}

showSmsCode(BuildContext context, MatchCubit bloc) async {
  await showDialog(
      context: context,
      builder: (BuildContext newContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => TimerBloc(Ticker())
                  ..add(TimerStarted(
                      duration: bloc.state.card.result.wait ~/ 1000))),
            BlocProvider(create: (context) => ResendSmsBloc()),
            BlocProvider(
                create: (context) =>
                    SendSmsCodeCubit(bloc, Repository.instance)),
            BlocProvider.value(value: context.bloc<MatchCubit>()),
          ],
          child: SmsCodeVerification(),
        );
      });
}

showPayment(BuildContext context, TextEditingController expireDate,
    TextEditingController cardNumber, TextEditingController amount,
    {bool lock, Function onPressed}) async {
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(lock ?? true),
        child: SimpleDialog(
          title: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop()),
              Text(
                "payment".tr(),
                textAlign: TextAlign.center,
                style: Style.bodyText2,
              ),
            ],
          ),
          titlePadding: EdgeInsets.only(top: 21, left: 8, right: 8),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("card_id".tr()),
                  ),
                  CustomTextField(
                    controller: cardNumber,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16)
                    ],
                    hintText: "8600 **** **** ****",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("expire_date".tr()),
                  ),
                  CustomTextField(
                    controller: expireDate,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                      // FilteringTextInputFormatter(
                      //     // RegExp(r"^(([0-1]{1})([0-9]{1})\/([2-5]{1})([0-9]{1}))$"),
                      //     // RegExp(r"^(0[1-9]{2}|1[0-2]{1})$"),
                      //     RegExp(r"^(0[1-9]|1[0-2])([0-9]|[0-9])$"),
                      //     allow: true)
                    ],
                    hintText: "05/25",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("payment_amount".tr()),
                  ),
                  CustomTextField(
                    readOnly: true,
                    controller: amount,
                    hintText: "MIN. UZS 5000",
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomButton(
              title: Text(
                "pay".tr(),
                style: Style.defaultText,
              ),
              onPressed: onPressed,
              width: double.infinity,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ));
}

showInfo(BuildContext context, {bool lock}) async {
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(lock ?? true),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "app_made_by".tr(),
                style: Style.bodyText2,
              ),
              Text(
                "SOFTCLUBUZ LLC",
                style: Style.defaultText,
              ),
              Text(
                "FUTURE DEVELOPMENT",
                style: Style.defaultText,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SelectableText(
                  "+998932499099",
                  style: Style.defaultText,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                title: Text(
                  "OK",
                  style: Style.defaultText,
                ),
                width: double.infinity,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              )
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ));
}

showLocalization(
  BuildContext context,
) async {
  Locale curLocale;
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              )
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme(
                data: ThemeData.dark(),
                child: DropdownButtonFormField<Locale>(
                  decoration: InputDecoration(
                      focusColor: ColorApp.blueAccent,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: ColorApp.bottomNavigationBarColor,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8))),
                  onChanged: (locale) {
                    curLocale = locale;
                  },
                  hint: Text(
                    context.locale.languageCode.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                  items: List.generate(
                      context.supportedLocales.length,
                      (index) => DropdownMenuItem(
                            value: context.supportedLocales[index],
                            child: Text(
                              '${context.supportedLocales[index].languageCode}'
                                  .tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: Text(
                  "save_settings".tr(),
                  style: Style.defaultText,
                ),
                width: double.infinity,
                onPressed: () {
                  if (curLocale != null) context.locale = curLocale;

                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ));
}
