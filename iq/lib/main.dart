import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/services/user_services.dart';

import 'global/functions.dart';
import 'screen/splash_screen.dart';
import 'services/app_services.dart';
import 'theme/app_theme.dart';
import 'firebase_options.dart';

Future initServices() async {
  await Get.putAsync(() => AppServices().init());
  await Get.putAsync(() => UserServices().init());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServices();
  ErrorWidget.builder = (details) => Material(
        color: Colors.green.shade200,
        child: Center(
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              details.exception.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    potrait();
    return GetMaterialApp(
      theme: apptheme(),
      home: const SplashScreen(),
      themeMode: ThemeMode.light,
      title: 'Inquisitive Questions',
      debugShowCheckedModeBanner: false,
    );
  }
}
