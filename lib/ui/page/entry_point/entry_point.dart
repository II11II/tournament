import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/page/home_page/home_page.dart';
import 'package:tournament/ui/page/login_page/login_cubit.dart';
import 'package:tournament/ui/page/login_page/login_page.dart';
import 'package:tournament/ui/page/main_page/main_page.dart';
import 'package:tournament/ui/page/splash_page/splash_page.dart';
import 'package:tournament/ui/style/color.dart';
import 'package:tournament/ui/style/style.dart';
import 'entry_point_cubit.dart';

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: MaterialApp(
          title: 'Tournament',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            iconTheme: IconThemeData(
              color: Colors.blueAccent,
            ),

            textTheme: TextTheme(
                bodyText2: Style.bodyText2,
                button: Style.defaultText,
                headline3: Style.headline3),
            scaffoldBackgroundColor: ColorApp.backgroundColor,
            appBarTheme: AppBarTheme(
                color: ColorApp.backgroundColor,
                elevation: 0,
                textTheme: TextTheme(headline6: Style.bodyText2)),
            primaryIconTheme: IconThemeData(color: Colors.white),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: ColorApp.bottomNavigationBarColor,
              elevation: 0,
              selectedIconTheme: IconThemeData(color: Colors.blueAccent),
              unselectedIconTheme: IconThemeData(color: Colors.white),
            ),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocBuilder(
              cubit: EntryPointCubit()..getScreen(),
              builder: (BuildContext context, state) {
                if (state is EntryPointNotAuthenticated)
                  return BlocProvider<LoginCubit>(
                      create: (context) => LoginCubit(), child: LoginPage());
                else if (state is EntryPointAuthenticated) {
                  return MainPage();
                } else {
                  return SplashPage();
                }
              })),
    );
  }
}
