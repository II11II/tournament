import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/main_page/main_cubit.dart';

import 'ui/page/entry_point/entry_point.dart';

Future main() async {
  runApp(EasyLocalization(
      supportedLocales: [Locale('ru'), Locale('en'), Locale('uz')],
      path: 'assets/translations',
      useOnlyLangCode: true,
      saveLocale: true,
      fallbackLocale: Locale('ru'),
      child: BlocProvider<MainCubit>(
          create: (BuildContext context) => MainCubit(), child: EntryPoint())));
}
