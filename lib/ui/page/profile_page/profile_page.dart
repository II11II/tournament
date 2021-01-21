import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tournament/bloc/withdraw/withdraw_bloc.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/page/profile_page/profile_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/style/style.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/no_connection.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class ProfilePage extends StatelessWidget {
  final cardController = TextEditingController();
  final holderController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (BuildContext context, state) async {
            if (state.state == NetworkState.LOADING) {
              showLoading(context);
            } else if (state.state == NetworkState.LOADED) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
            } else if (state.state == NetworkState.SERVER_ERROR) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            } else if (state.state == NetworkState.INVALID_TOKEN) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red,
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EntryPoint())));
            } else if (state.state == NetworkState.NO_CONNECTION) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              await showMessage(
                  context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            }
          },
          builder: (context, state) {
            if (state.state == NetworkState.LOADED)
              return body(context);
            else if (state.state == NetworkState.NO_CONNECTION)
              return NoConnection(
                onPressed: () async =>
                    await context.bloc<ProfileCubit>().init(),
              );
            else
              return Container();
          },
          listenWhen: (p, c) => p.state != c.state,
          buildWhen: (p, c) => p.state != c.state,
        ));
  }

  Widget body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = context.bloc<ProfileCubit>();
    var withdrawBloc = context.bloc<WithdrawBloc>();

    return SingleChildScrollView(
      child: Stack(
        children: [
          // Container(
          //   height: size.height-300,
          //   width: size.width,
          // ),
          Column(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black26, Colors.black54, Colors.black],
                  ),
                ),
                height: 320,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        // colorFilter:
                        //     ColorFilter.mode(Colors.black38, BlendMode.darken),
                        image: CachedNetworkImageProvider(
                          '${bloc.state.player.backgroundImage}',
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            border: NeumorphicBorder(
                              color: ColorApp.backgroundColor,
                              width: 0.8,
                            ),
                            color: ColorApp.backgroundColor,
                            shadowDarkColor: Colors.black,
                            shape: NeumorphicShape.flat,
                            shadowLightColor: Colors.grey.shade900,
                            shadowDarkColorEmboss: Colors.black,
                            depth: 10),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          initialValue: '${bloc.state.player.pubgId}',
                          style: Style.px16W300,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "PUBG ID:",
                                  style: Style.px16W300,
                                ),
                              ),
                              // prefixText:"PUBG ID:" ,
                              filled: true,
                              suffixStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                              prefixStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                FeatherIcons.edit,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            border: NeumorphicBorder(
                              color: ColorApp.backgroundColor,
                              width: 0.8,
                            ),
                            color: ColorApp.backgroundColor,
                            shadowDarkColor: Colors.black,
                            shadowLightColor: Colors.grey.shade900,
                            shadowDarkColorEmboss: Colors.black,
                            depth: 10),
                        child: TextFormField(
                          initialValue: '${bloc.state.player.username}',
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                          style: Style.px16W300,
                          decoration: InputDecoration(
                              isDense: true,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "pubg_username".tr(),
                                  style: Style.px16W300,
                                ),
                              ),
                              filled: true,
                              suffixStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                              prefixStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                FeatherIcons.edit,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    BlocListener<WithdrawBloc, WithdrawState>(
                      listener: (BuildContext context, state) async {
                        if (state is WithdrawLoading) {
                          showLoading(context);
                        } else if (state is WithdrawLoaded) {
                          if (Navigator.of(context, rootNavigator: true)
                              .canPop())
                            Navigator.of(context, rootNavigator: true).pop();
                          showMessage(context, "application_accepted".tr(), Icons.check_circle,
                              iconColor: Colors.greenAccent);
                        } else if (state is WithdrawError) {
                          if (Navigator.of(context, rootNavigator: true)
                              .canPop())
                            Navigator.of(context, rootNavigator: true).pop();
                          showMessage(context, state.message,
                              Icons.report_problem_outlined,
                              iconColor: Colors.red);
                        }
                      },
                      child: CustomButton(
                        onPressed: () {
                          showWithdraw(context,
                              amount: amountController,
                              card: cardController,
                              holder: holderController,
                              onPressed: () => withdrawBloc.add(Withdraw(
                                  cardController.text,
                                  holderController.text,
                                  amountController.text)));
                        },
                        title: Text(
                          'withdraw'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff3B0BFE))),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(
                        '${bloc.state.player.image}',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      '${bloc.state.player.firstName}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Color(0xff1877DE),
                                Color(0xff3B0BFE)
                              ],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Neumorphic(
                      margin: EdgeInsets.all(8),
                      style: NeumorphicStyle(
                          color: ColorApp.backgroundColor,
                          shadowDarkColor: Colors.black,
                          shadowLightColor: Colors.grey.shade900,
                          shadowDarkColorEmboss: Colors.black,
                          depth: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'balance'.tr(),
                            style: Style.px16W300,
                          ),
                          FittedBox(
                              child: Text(
                            '${bloc.state.player.balance.toInt()}\nUZS',
                            textAlign: TextAlign.center,
                            style: Style.px16W300,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Neumorphic(
                      margin: EdgeInsets.all(8),
                      // shadowColor: Colors.grey.shade600,
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      style: NeumorphicStyle(
                          color: ColorApp.backgroundColor,
                          shadowDarkColor: Colors.black,
                          shadowLightColor: Colors.grey.shade900,
                          shadowDarkColorEmboss: Colors.black,
                          depth: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'revenue'.tr(),
                            style: Style.px16W300,
                          ),
                          FittedBox(
                              child: Text(
                            '${bloc.state.player.revenue.toInt()}\nUZS',
                            textAlign: TextAlign.center,
                            style: Style.px16W300,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Neumorphic(
                      margin: EdgeInsets.all(8),
                      style: NeumorphicStyle(
                          color: ColorApp.backgroundColor,
                          shadowDarkColor: Colors.black,
                          shadowLightColor: Colors.grey.shade900,
                          shadowDarkColorEmboss: Colors.black,
                          depth: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'matches'.tr(),
                            style: Style.px16W300,
                          ),
                          FittedBox(
                              child: Text(
                            '${bloc.state.player.matches}',
                            style: Style.px16W300,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
