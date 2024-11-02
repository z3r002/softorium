import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/shared/consts/global.dart';
import 'package:get_it/get_it.dart';
import 'package:softoriim/utils/task_storage_helper.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    GetIt.I.registerSingleton<HomeStore>(HomeStore(TaskStorageHelper(prefs)));

    runApp(EasyLocalization(
        supportedLocales: [Locale('ru'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp()));
  }, (exception, stackTrace) async {});
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Nunito'),
      title: 'softorium',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: appRouter.config(),
    );
  }
}
