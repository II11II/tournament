import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/forget_password_page/forget_password_cubit.dart';
import 'package:tournament/ui/page/forget_password_page/forget_password_page.dart';
import 'package:tournament/ui/page/login_page/login_cubit.dart';
import 'package:tournament/ui/page/main_page/main_page.dart';
import 'package:tournament/ui/page/sign_up_page/sign_up_cubit.dart';
import 'package:tournament/ui/page/sign_up_page/sign_up_page.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = context.bloc<LoginCubit>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login_background.png'))),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'log_in'.tr(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('appointment_app'.tr()),
                      SizedBox(
                        height: 32,
                      ),
                      CustomTextField(
                        hintText: 'login'.tr(),
                        autoValidate: true,
                        controller: bloc.loginField,
                        validator:
                            bloc.loginFieldValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        autoValidate: true,
                        hintText: 'password'.tr(),
                        textInputType: TextInputType.visiblePassword,
                        controller: bloc.passwordField,
                        obscureText: true,
                        validator:
                            bloc.passwordFieldValidator,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) async {
                          if (state.networkState == NetworkState.LOADED) {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage()));
                          } else if (state.networkState ==
                              NetworkState.INVALID_CREDENTIALS) {
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop())
                              Navigator.of(context, rootNavigator: true).pop();
                            showMessage(context, 'Error', FeatherIcons.x,
                                iconColor: Colors.redAccent);
                          } else if (state.networkState ==
                              NetworkState.LOADING) {
                            showLoading(context);
                          } else {
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop())
                              Navigator.of(context, rootNavigator: true).pop();
                            showMessage(context, 'Error', FeatherIcons.x);
                          }
                        },
                        listenWhen: (p,c)=>p.networkState!=c.networkState,

                        buildWhen: (p, c) => c.isButtonActive != p.isButtonActive,
                        builder: (context, state) => CustomButton(
                          colors: !state.isButtonActive
                              ? [
                                  Colors.grey,
                                  Colors.grey,
                                ]
                              : null,
                          height: 55,
                          text: "log_in".tr(),
                          onPressed: !state.isButtonActive
                              ? null
                              : () {
                                  context.bloc<LoginCubit>().login();
                                },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? signUp(context)
                  : Container()
            ],
          ),
        ));
  }

  Widget signUp(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlineButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) => BlocProvider(
                                create: (context) => ForgetPasswordCubit(),
                                child: ForgetPasswordPage())));
                  },
                  color: Colors.white.withAlpha(100),
                  child: Text(
                    "${'forget_password'.tr()} ?",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              Text(
                "not_registered".tr(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) => BlocProvider(
                                create: (context) => SignUpCubit(),
                                child: SignUpPage())));
                  },
                  child: Text(
                    'sign_up'.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
