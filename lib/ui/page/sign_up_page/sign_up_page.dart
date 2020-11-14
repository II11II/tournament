import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/main_page/main_page.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:tournament/ui/widget/pop_up.dart';

import 'sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  final loginField = TextEditingController();
  final passwordField = TextEditingController();
  final emailField = TextEditingController();
  final passwordConfirmField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/sign_up_background.png'))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        child
                            : Text(
                          'sign_up'.tr(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('appointment_app'.tr()),
                      SizedBox(
                        height: 32,
                      ),
                      CustomTextField(
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        hintText: "login".tr(),
                        controller: loginField,
                        validator:
                        context
                            .bloc<SignUpCubit>()
                            .loginFieldValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        hintText: "password".tr(),
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        controller: passwordField,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator:
                        context
                            .bloc<SignUpCubit>()
                            .passwordFieldValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: passwordConfirmField,
                        hintText: "confirm_password".tr(),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        validator: context
                            .bloc<SignUpCubit>()
                            .passwordConfirmFieldValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: emailField,
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        hintText: "email".tr(),
                        textInputType: TextInputType.emailAddress,
                        validator:
                        context
                            .bloc<SignUpCubit>()
                            .emailFieldValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: emailField,
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        hintText: "PUBG ID",
                        textInputType: TextInputType.emailAddress,
                        validator:
                        context
                            .bloc<SignUpCubit>()
                            .emailFieldValidator,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          if (state.state == NetworkState.LOADED) {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()));
                          }
                          else if (state.state == NetworkState.LOADING) {
                            showLoading(context);
                          }
                           else {
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop()) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            showMessage(context, state.message, Icons.warning,
                                iconColor: Colors.red);
                          }
                        },
                        listenWhen: (p, c) => p.state != c.state,
                        builder: (context, state) =>
                            CustomButton(
                              colors: !state.isButtonActive
                                  ? [
                                Colors.grey,
                                Colors.grey,
                              ]
                                  : null,
                              height: 55,
                              text: "sign_up".tr(),
                              onPressed: !state.isButtonActive
                                  ? null
                                  : () {
                                context.bloc<SignUpCubit>().register(
                                    loginField.text,
                                    passwordField.text,
                                    emailField.text);
                              },
                            ),
                      )
                    ],
                  ),
                ),
              ),
              MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom == 0
                  ? signUp(context)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "registered".tr(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          FlatButton(
              onPressed: () {
                Navigator.popUntil(context, (r) => r.isFirst);
              },
              child: Text(
                'log_in'.tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ))
        ],
      ),
    );
  }
}
