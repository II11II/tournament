import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          title: 'Tournament',themeMode: ThemeMode.dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          darkTheme: ThemeData(
            canvasColor: Color(0xff12151A),
            dialogTheme: DialogTheme(backgroundColor: Color(0xff12151A)),
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: ColorApp.drawerColor,
                elevation: 5,
                modalElevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)))),
            iconTheme: IconThemeData(
              color: Colors.blueAccent,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white),
            ),
            cardTheme: CardTheme(
                color: Color(0xff12151A),
                elevation: 10,
                shape: RoundedRectangleBorder(),
                shadowColor: Color.alphaBlend(Colors.black, Colors.white)),
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
          home: BlocListener(
            cubit: EntryPointCubit()..getScreen(),
            listener: (BuildContext context, state) {
              if (state is EntryPointNotAuthenticated)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<LoginCubit>(
                            create: (context) => LoginCubit(),
                            child: LoginPage())));
              else if (state is EntryPointAuthenticated) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<LoginCubit>(
                            create: (context) => LoginCubit(),
                            child: LoginPage())));
              }
            },
            child: SplashPage(),
          )),
    );
  }
}
