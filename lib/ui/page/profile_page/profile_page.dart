import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/page/profile_page/profile_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/style/style.dart';
import 'package:tournament/ui/widget/custom_button.dart';
import 'package:tournament/ui/widget/no_connection.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class ProfilePage extends StatelessWidget {
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
        }, builder: (context, state) {
          if (state.state == NetworkState.LOADED)
            return body(context);
          else if (state.state == NetworkState.NO_CONNECTION)
            return NoConnection(
              onPressed: () async => await context.bloc<ProfileCubit>().init(),
            );
          else
            return Container();
        }));
  }

  Widget body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = context.bloc<ProfileCubit>();

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            width: size.width,
            decoration: BoxDecoration(

                image: DecorationImage(
                    fit: BoxFit.cover,
                 colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                    image: CachedNetworkImageProvider(
                      '${bloc.state.player.backgroundImage}',
                    ))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
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
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${bloc.state.player.firstName}',
                      style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Color(0xff1877DE),
                                Color(0xff3B0BFE)
                              ],
                            ).createShader(
                                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Card(
                            shadowColor: Colors.grey.shade600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('balance'.tr()),
                                FittedBox(
                                    child: Text(
                                  '${bloc.state.player.balance.toInt()}\nUZS',
                                  textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Card(
                            shadowColor: Colors.grey.shade600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('revenue'.tr()),
                                FittedBox(
                                    child: Text(
                                  '${bloc.state.player.revenue.toInt()}\nUZS',
                                  textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Card(
                            shadowColor: Colors.grey.shade600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('matches'.tr()),
                                FittedBox(
                                    child: Text('${bloc.state.player.matches}'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: Card(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        initialValue: '${bloc.state.player.pubgId}',
                        style: Style.defaultText,

                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "PUBG ID:",
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
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: Card(
                      child: TextFormField(
                        initialValue: '${bloc.state.player.username}',
                        textInputAction: TextInputAction.done,
                        readOnly: true,
                        style: Style.defaultText,
                        decoration: InputDecoration(
                            labelText: "pubg_username".tr(),
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
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: CustomButton(
                      onPressed: () {
                        showWithdraw(context);
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
          ),
        ),
      ],
    );
  }
}
