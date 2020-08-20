import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/page/premium_page/premium_page.dart';
import 'package:tournament/ui/page/today_page/today_page.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/widget/match_card.dart';
import 'package:tournament/ui/widget/premium_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(context),
      body: _body(context),
      appBar: _appBar(context),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        leading: Container(),
        title: Text('home_page'.tr()),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(FeatherIcons.alignRight),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          })
        ],
      );

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        shrinkWrap: true,
        children: [
          _title(context, 'premium'.tr(), PremiumPage()),
          PremiumCard(),
          _title(context, 'today'.tr(), TodayPage(appBarTitle: 'today'.tr())),
          Container(
            height: 252,
            width: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MatchCard(
                    onPressed: () {},
                  );
                }),
          ),
          _title(context, 'upcoming'.tr(),
              TodayPage(appBarTitle: 'upcoming'.tr())),
          Container(
            height: 252,
            width: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MatchCard(
                    onPressed: () {},
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context, String title, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        FlatButton(
          child: Text(
            'view_all'.tr(),
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (BuildContext context) {
              return child;
            }));
          },
        )
      ],
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorApp.drawerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: DrawerHeader(
                child: FittedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/logo.png"),

                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('pubg_arena'.tr(),style: Theme.of(context).textTheme.headline3,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin:  Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: Text('language'.tr(),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),),
                    ),
                  ),
                ), Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin:  Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      leading: Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                      title: Text('rate_app'.tr(),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),),
                    ),
                  ),
                ), Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin:  Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text('info'.tr(),style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/future_development_logo.png'),
            )
          ],
        ),
      ),
    );
  }
}
