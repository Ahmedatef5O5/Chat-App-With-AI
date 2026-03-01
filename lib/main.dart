import 'package:chat_app_with_ai/Router/app_router.dart';
import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/utilities/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat with AI',
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.chat,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
