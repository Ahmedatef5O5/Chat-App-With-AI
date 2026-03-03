import 'package:chat_app_with_ai/Router/app_router.dart';
import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app_with_ai/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_with_ai/firebase_options.dart';
import 'package:chat_app_with_ai/utilities/theme/app_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    // androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
    // providerAndroid: AndroidAppCheckProvider.playIntegrity,
  );

  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,

        debugShowCheckedModeBanner: false,
        title: 'Chat with AI',
        theme: AppTheme.themeData,
        // home: RegisterView(),
        initialRoute: AppRoutes.register,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
