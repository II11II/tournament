import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tournament/model/tournament.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/style/style.dart';
import 'package:tournament/ui/widget/match_card/match_card_cubit.dart';

import '../pop_up.dart';

class MatchCard extends StatelessWidget {
  final Function onPressed;
  final Tournament tournament;
  final String buttonTitle;
  final bloc = MatchCardCubit();
  final log = Logger();

  MatchCard({
    Key key,
    this.onPressed,
    this.tournament,
    this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bloc.state.isLiked = tournament.isFavourite;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Card(
          color: ColorApp.backgroundColor,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    GestureDetector(
                      onTap: onPressed,
                      child: CachedNetworkImage(
                        imageUrl: tournament.image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, text) {
                          return Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.yellow,
                            enabled: true,
                            child: Container(
                              height: 150,
                              width: 150,
                            ),
                          );
                        },
//                  color: Theme.of(context).appBarTheme.color.withAlpha(10),
                        progressIndicatorBuilder: (context, text, d) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 110,
                      width: 150,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black26, Colors.black54, Colors.black],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 5,
                        right: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                                flex: 4,
                                child: Text(
                                  '${tournament.name}',
                                  style: Style.defaultText,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Flexible(
                              child: IconButton(
                                icon: BlocConsumer<MatchCardCubit, MatchCardState>(
                                    listenWhen: (p, c) =>
                                        p.networkState != c.networkState,
                                    listener: (context, state) {
                                      if (state.networkState ==
                                              NetworkState.LOADED ||
                                          state.networkState ==
                                              NetworkState.LOADING) {
                                      } else if (state.networkState ==
                                          NetworkState.INVALID_TOKEN) {
                                        showMessage(context, state.message,
                                            Icons.report_problem_outlined,
                                            iconColor: Colors.red,
                                            onPressed: () =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EntryPoint())));
                                      } else {
                                        showMessage(context, state.message,
                                            Icons.report_problem_outlined,
                                            iconColor: Colors.red);
                                      }
                                    },
                                    cubit: bloc,
                                    builder: (context, state) {
                                      if (state.networkState ==
                                              NetworkState.LOADED &&
                                          state.isLiked)
                                        return Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        );
                                      else if (state.networkState ==
                                              NetworkState.LOADED &&
                                          state.isLiked)
                                        return Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        );
                                      else if (state.networkState ==
                                          NetworkState.LOADING)
                                        return Container();
                                      else {
                                        if (state.isLiked)
                                          return Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          );
                                        else
                                          return Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                          );
                                      }
                                    }),
                                onPressed: () async =>
                                    await bloc.likePress(tournament.id),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: onPressed,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FeatherIcons.dollarSign,
                          color: Colors.white,
                        ),
                        Text(
                          ' ${'cost'.tr()}/${'kill'.tr()}:\n UZS${tournament.cost.toInt()}/${tournament.killRevenue.toInt()}',
                          style: Style.extraSmallText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_outline,
                          color: Colors.white,
                        ),
                        Text(
                          ' ${'seats_left'.tr()}: ${tournament.players.length}/${tournament.maxPlayers}',
                          style: Style.extraSmallText,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        buttonTitle ?? 'get_ticket'.tr(),
                        style: Style.smallText.copyWith(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
