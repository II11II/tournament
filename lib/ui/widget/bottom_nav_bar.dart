

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/main_page/main_cubit.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              FeatherIcons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              FeatherIcons.shoppingCart,
            ),
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              FeatherIcons.user,
            ),
          ),
        ],
        onTap: (value) => context.bloc<MainCubit>().changePage(value),
        currentIndex: state.index,
      );
    });
  }
}
