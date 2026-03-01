import 'package:chat_app_with_ai/views/home_view.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return CupertinoPageRoute(builder: (context) => HomeView());
    }
  }
}
