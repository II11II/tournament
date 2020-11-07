import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/page/favourite_tournament_page/favourite_tournament_cubit.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/page/match_page/match_page.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/match_card/match_card.dart';
import 'package:tournament/ui/widget/no_connection.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class FavouriteTournamentPage extends StatelessWidget {
  const FavouriteTournamentPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favourite_tournaments".tr()),
      ),
      body: BlocConsumer<FavouriteTournamentCubit, FavouriteTournamentState>(
        listener: (BuildContext context, state) async {

          if (state.networkState == NetworkState.LOADING) {
            showLoading(context);
          } else if (state.networkState == NetworkState.LOADED) {
            // if (Navigator.of(context, rootNavigator: true, ).canPop())
            //   Navigator.of(context, rootNavigator: true).pop();
          } else if (state.networkState == NetworkState.INVALID_TOKEN) {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
            showMessage(context, state.message, Icons.report_problem_outlined,
                iconColor: Colors.red,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EntryPoint())));
          } else {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
            await showMessage(
                context, state.message, Icons.report_problem_outlined,
                iconColor: Colors.red);
          }
        },
        builder: (context, state) {
          if (state.networkState == NetworkState.LOADED)
            return body(context);
          else if (state.networkState == NetworkState.NO_CONNECTION)
            return NoConnection(
              onPressed: context.bloc<FavouriteTournamentCubit>().init,
            );
          else
            return Container();
        },
      ),
    );
  }

  Widget body(BuildContext context) {
    var bloc = context.bloc<FavouriteTournamentCubit>();
    return GridView.builder(
      itemCount: bloc.state.favouriteTournaments.length,
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          child: MatchCard(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider(
                    create: (BuildContext context) => MatchCubit(
                        bloc.state.favouriteTournaments[index].tournament),
                    child: MatchPage());
              }));
            },
            tournament: bloc.state.favouriteTournaments[index].tournament,
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/1.3
      ),
    );
  }
}
