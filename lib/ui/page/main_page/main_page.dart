import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/home_page/home_page.dart';
import 'package:tournament/ui/page/my_tickets_page/my_tickets_page.dart';
import 'package:tournament/ui/page/profile_page/profile_page.dart';
import 'package:tournament/ui/widget/bottom_nav_bar.dart';
import 'main_cubit.dart';

class MainPage extends StatelessWidget {
  final _kTabPages = <Widget>[HomePage(), MyTicketsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
          return _kTabPages[context.bloc<MainCubit>().state.index];
        }),
      );

  }

}

