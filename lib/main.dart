import 'dart:async';

import 'package:chat_demo/core/locator/locator.dart';
import 'package:chat_demo/core/routes/app_router.dart';
import 'package:chat_demo/firebase_options.dart';
import 'package:chat_demo/values/constant.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'values/theme.dart' as theme;

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await setupLocator();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((value) =>
        runApp(
          ProviderScope(child: MyApp()),
        ),);
  }, (error, stack) {
    debugPrint('Error :${error.toString()}');
    debugPrintStack(label: 'RunApp', stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRoutes = getIt<AppRouter>();


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, child) =>
          MaterialApp.router(
            title: 'chat Demo',
            routerConfig:appRoutes.config(),
            debugShowCheckedModeBanner: false,
            theme: theme.light,
            darkTheme: theme.dark,
            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
          ),
    );
  }
}
//final appRoutes = getIt<AppRoutes>();


