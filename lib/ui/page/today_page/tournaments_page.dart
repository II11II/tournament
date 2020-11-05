import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/page/match_page/match_page.dart';
import 'package:tournament/ui/page/today_page/tournaments_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/match_card/match_card.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class TournamentsPage extends StatelessWidget {
  final String appBarTitle;

  const TournamentsPage({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: BlocConsumer<TournamentCubits, TournamentsState>(
          listener: (BuildContext context, state) {
            if (state.networkState == NetworkState.LOADING) {
              showLoading(context);
            } else if (state.networkState == NetworkState.LOADED) {
              // if (Navigator.of(context, rootNavigator: true).canPop())
              //   Navigator.of(context, rootNavigator: true).pop();
            } else if (state.networkState == NetworkState.SERVER_ERROR) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            } else if (state.networkState == NetworkState.INVALID_TOKEN) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red,
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EntryPoint())));
            } else if (state.networkState == NetworkState.NO_CONNECTION) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            }
          },
          listenWhen: (p, c) => p.networkState != c.networkState,
          buildWhen: (p, c) => p.networkState != c.networkState,
          builder: (context, state) {
            if (state.networkState == NetworkState.LOADED)
              return body(context);
            else
              return Container();
          }),
    );
  }

  Widget body(BuildContext context) {
    var bloc = context.bloc<TournamentCubits>();
    return RefreshIndicator(
      onRefresh: () async{

      },
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
          shrinkWrap: true,
          itemCount: bloc.state.tournaments.length ,
          itemBuilder: (context, index) {
            return FittedBox(
                child: MatchCard(
              tournament: bloc.state.tournaments[index],
              onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (c) => BlocProvider(
                          create: (BuildContext context) =>
                              MatchCubit(bloc.state.tournaments[index]),
                          child: MatchPage()))),
            ));
          }),
    );
  }
}
