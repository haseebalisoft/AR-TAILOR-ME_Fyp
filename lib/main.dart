import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/firebase_options.dart';
import 'package:tailer_app/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tailer App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff2a87ef),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        primaryColor: Color(0xff2a87ef),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff2a87ef),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
