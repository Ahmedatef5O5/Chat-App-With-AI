import 'package:chat_app_with_ai/Router/app_router.dart';
import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/firebase_options.dart';
import 'package:chat_app_with_ai/utilities/theme/app_theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
    // providerAndroid: AndroidAppCheckProvider.playIntegrity,
  );

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
