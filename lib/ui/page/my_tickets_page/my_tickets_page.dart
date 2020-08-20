import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/widget/match_card.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_tickets'.tr()),
      ),
      body: body(),
    );
  }

  Widget body() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FittedBox(child: MatchCard());
        });
  }
}
