
import 'package:auto_route/auto_route.dart';
import 'package:chat_demo/core/locator/locator.dart';
import 'package:chat_demo/screens/auth/login/login_page.dart';
import 'package:chat_demo/screens/auth/otp/otp_page.dart';
import 'package:chat_demo/screens/auth/signup/signup_page.dart';
import 'package:chat_demo/screens/home_page/home_page.dart';
import 'package:chat_demo/screens/profile/profile_page.dart';
import 'package:chat_demo/screens/splash_screens/splash_screens.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page:LoginRoute.page),
    AutoRoute(page:SignupRoute.page),
    AutoRoute(page:SplashRoute.page,initial: true),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}
final appRouter = getIt<AppRouter>();

