import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/views/home_view.dart';
import 'package:chat_app_with_ai/views/login_view.dart';
import 'package:flutter/cupertino.dart';

import '../views/register_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.chat:
        return CupertinoPageRoute(builder: (context) => HomeView());

      case AppRoutes.register:
        return CupertinoPageRoute(builder: (context) => RegisterView());

      case AppRoutes.login:
        return CupertinoPageRoute(builder: (context) => LoginView());

      default:
        return CupertinoPageRoute(builder: (context) => HomeView());
      // return SizedBox.shrink();
    }
  }
}
