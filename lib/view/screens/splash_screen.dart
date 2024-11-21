import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tailer_app/utils/app-constant.dart';
import 'package:tailer_app/view/screens/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 13), () {
      Get.offAll(() => IntroScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Your background image
            fit: BoxFit.cover, // Makes sure the image covers the entire screen
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/logo.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: TextStyle(
                    color: AppConstant.appTextColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
