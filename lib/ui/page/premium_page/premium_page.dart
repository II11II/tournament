import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/home_page/home_cubit.dart';
import 'package:tournament/ui/page/match_page/match_cubit.dart';
import 'package:tournament/ui/page/match_page/match_page.dart';
import 'package:tournament/ui/widget/premium_card.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('premium'.tr()),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    var bloc = context.bloc<HomeCubit>();
    return ListView.builder(
      itemCount: bloc.state.premiumTournaments.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PremiumCard(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(create: (context)=>MatchCubit(bloc.state.premiumTournaments[index]), child: MatchPage()))),
          ),
        );
      },
    );
  }
}
