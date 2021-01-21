import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/forget_password_page/forget_password_cubit.dart';
import 'package:tournament/ui/page/sign_up_page/sign_up_cubit.dart';
import 'package:tournament/ui/page/sign_up_page/sign_up_page.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/custom_textfield.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        'forget_password'.tr(),
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
                        hintText: 'phone_number'.tr(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            context.bloc<ForgetPasswordCubit>().loginField,
                        validator:
                            context.bloc<ForgetPasswordCubit>().loginValidator,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                          buildWhen: (p, c) =>
                              p.isActivePassField != c.isActivePassField,
                          builder: (context, ForgetPasswordState state) {
                            if (state.isActivePassField)
                              return CustomTextField(
                                autoValidate: true,

                                hintText: 'pass_code'.tr(),
                                textInputType: TextInputType.visiblePassword,
                                controller: context
                                    .bloc<ForgetPasswordCubit>()
                                    .passwordField,

                                obscureText: true,
                                // validator:
                                // context.bloc<ForgetPasswordCubit>().passwordFieldValidator,
                              );
                            else
                              return Container();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                        listener: (BuildContext context, state) {
                          if (state.state == NetworkState.LOADING)
                            showLoading(context);
                          else if (state.state == NetworkState.LOADED) {
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop())
                              Navigator.of(context, rootNavigator: true).pop();
                          } else if (state.state ==
                              NetworkState.INVALID_TOKEN) {
                           
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop())
                              Navigator.of(context, rootNavigator: true).pop();
                            showMessage(context, "state.message", Icons.delete);
                          }else  {
                           
                            if (Navigator.of(context, rootNavigator: true)
                                .canPop())
                              Navigator.of(context, rootNavigator: true).pop();
                            showMessage(context, "error", Icons.delete);
                          }
                        },
                        listenWhen: (p, c) => p.state != c.state,
                        builder: (context, state) => CustomButton(
                            colors: !state.isButtonActive
                                ? [
                                    Colors.grey,
                                    Colors.grey,
                                  ]
                                : null,
                            height: 55,
                            text: "next".tr(),
                            onPressed: state.isButtonActive
                                ? () async => await context
                                    .bloc<ForgetPasswordCubit>()
                                    .nextButton()
                                : null),
                      ),
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
