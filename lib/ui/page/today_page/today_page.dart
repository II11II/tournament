import 'package:flutter/material.dart';
import 'package:tournament/ui/widget/bottom_nav_bar.dart';
import 'package:tournament/ui/widget/match_card.dart';

class TodayPage extends StatelessWidget {
  final String appBarTitle;

  const TodayPage({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: body(),
    );
  }

  Widget body() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FittedBox(child: MatchCard());
        });
  }
}
