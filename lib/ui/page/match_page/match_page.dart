import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/widget/custom_button.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  var isExpanded = false;
  final List<IconData> _icons = [
    FeatherIcons.dollarSign,
    FeatherIcons.activity,
    FeatherIcons.award
  ];

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = context.bloc<MatchCubit>();

    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: bloc.state.tournament.image,
              fit: BoxFit.cover,
              height: 250,
              width: size.width,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                ),
              ]),
            ),
            SafeArea(child: appBar(context)),
            Positioned(
              bottom: 5,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${bloc.state.tournament.cost}'),
                  IconButton(
                    icon: Icon(FeatherIcons.heart),
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(context, 'about_the_match'.tr(),
                      () => bloc.expandDescription()),
                  BlocBuilder<MatchCubit, MatchState>(
                    builder: (context, MatchState state) => AnimatedCrossFade(
                      firstChild: Text(
                        '${bloc.state.tournament.description}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                        maxLines: 3,
                      ),
                      secondChild: Text(
                        '${bloc.state.tournament.description}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      crossFadeState: !state.isDescriptionExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),
                  ),
                  _title(context, 'match_instructions'.tr(),
                      () => bloc.expandInstruction()),
                  BlocBuilder<MatchCubit, MatchState>(
                    builder: (context, MatchState state) => AnimatedCrossFade(
                      firstChild: Text(
                        '${bloc.state.tournament.instructions}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                        maxLines: 3,
                      ),
                      secondChild: Text(
                        '${bloc.state.tournament.instructions}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      crossFadeState: !state.isInstructionExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: Text(
                      'prizes'.tr(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0;
                          i < bloc.state.tournament.prizes.length;
                          i++)
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  width: 90,
                                  height: 90,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    borderOnForeground: true,
                                    elevation: 5,
                                    shadowColor: Colors.grey,
                                    child: Icon(
                                      _icons[i],
                                      size: 50,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${bloc.state.tournament.prizes[i].price.toInt()}\nUZS\n${'${bloc.state.nameTournament[i]}'.tr()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorApp.blueAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AnimatedCrossFade(
            firstChild: CustomButton(
              text: "get_ticket_now".tr(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.blueAccent, blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: BottomSheet(
                            enableDrag: true,
                            animationController: animationController,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 8, right: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('get_ticket_now'.tr()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('total_payment'.tr()),
                                                FittedBox(child: Text('UZS 20'))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('payment_option'.tr()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Card(
                                                  color: ColorApp
                                                      .backgroundColor
                                                      .withBlue(40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                        'assets/images/pay_me_logo.png'),
                                                  ),
                                                ),
                                                // Card(
                                                //   color: ColorApp.drawerColor,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               8)),
                                                //   child: Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: Image.asset(
                                                //         'assets/images/click_logo.png'),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          CustomButton(
                                            text: 'buy_now'.tr(),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            onClosing: () {},
                          ),
                        ),
                      );
                    });
              },
            ),
            duration: Duration(seconds: 1),
            crossFadeState: CrossFadeState.showFirst,
            secondChild: Container(),
          ),
        )
      ],
    );
  }

  Widget _title(BuildContext context, String title, Function onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        FlatButton(
          child: Text(
            'more_info'.tr(),
            style: Theme.of(context).textTheme.button.copyWith(
                fontWeight: FontWeight.w700, color: ColorApp.blueAccent),
          ),
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget appBar(BuildContext context) {
    var bloc = context.bloc<MatchCubit>();
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${bloc.state.tournament.name}',
            style: TextStyle(),
          ),
        ))
      ],
    );
  }
}
