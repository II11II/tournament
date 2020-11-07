import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/entry_point/entry_point.dart';
import 'package:tournament/ui/page/favourite_tournament_page/favourite_tournament_cubit.dart';
import 'package:tournament/ui/page/favourite_tournament_page/favourite_tournament_page.dart';
import 'package:tournament/ui/page/my_tickets_page/my_tickets_cubit.dart';
import 'package:tournament/ui/state/network_state.dart';
import 'package:tournament/ui/widget/match_card/match_card.dart';
import 'package:tournament/ui/widget/no_connection.dart';
import 'package:tournament/ui/widget/pop_up.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_tickets'.tr()),
      ),
      body: BlocConsumer<MyTicketsCubit, MyTicketsState>(
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
            onPressed: () async =>
                await context.bloc<MyTicketsCubit>().getMyTickets(),
          );
        else
          return RefreshIndicator(
              onRefresh: () async =>
                  await context.bloc<MyTicketsCubit>().getMyTickets(),
              child: ListView());
      }),
      floatingActionButton: fab(context),
    );
  }

  Widget fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => BlocProvider(
                  create: (BuildContext context) =>
                      FavouriteTournamentCubit()..init(),
                  child: FavouriteTournamentPage()))),
      child: Icon(Icons.favorite),
    );
  }

  Widget body(BuildContext context) {
    var bloc = context.bloc<MyTicketsCubit>();
    return RefreshIndicator(
      onRefresh: () async=>await bloc.getMyTickets(),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
          shrinkWrap: true,
          itemCount: bloc.state.myTickets.length,
          itemBuilder: (context, index) {
            return FittedBox(
                child: MatchCard(
              tournament: bloc.state.myTickets[index].tournament,
              buttonTitle: "ticket".tr(),
              onPressed: () {
                var info=bloc.state.myTickets[index].tournament;
              showTicket(context,info.matchId,info.password,info.instructions);
              },
            ));
          }),
    );
  }
}
