import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/views/home_view.dart';
import 'package:chat_app_with_ai/views/login_view.dart';
import 'package:chat_app_with_ai/views/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/register_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return CupertinoPageRoute(builder: (context) => SplashView());

      case AppRoutes.register:
        return CupertinoPageRoute(builder: (context) => RegisterView());

      case AppRoutes.login:
        return CupertinoPageRoute(builder: (context) => LoginView());

      case AppRoutes.chat:
        return CupertinoPageRoute(builder: (context) => HomeView());

      default:
        return CupertinoPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
