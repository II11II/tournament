import 'package:flutter/material.dart';
import 'package:tournament/ui/widget/bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/widget/premium_card.dart';
class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(title: Text('premium'.tr()),),
      body: body(),
    );
  }
  Widget body(){
    return ListView.builder(itemCount: 10,itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: PremiumCard(),
      );
    },);
  }
}
