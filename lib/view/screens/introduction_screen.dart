import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:tailer_app/view/screens/ask_panel.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Customize Your Shirts",
          body:
              "We provide a feature that allows you to customise and order a shirt of your own choice",
          image: Center(child: Image.asset("assets/image1.png", height: 300.0)),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "View Dress Via AR",
          body:
              "Using the latest technology of AR you can try on dresses of any material and products in our app",
          image: Center(child: Image.asset("assets/image2.png", height: 300.0)),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () {
        Get.off(() => WelcomeScreen()); // Navigate to your home screen
      },
      onSkip: () {
        Get.off(() =>WelcomeScreen()); // You can also skip the intro screen
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: getDotDecoration(),
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      size: const Size(10.0, 10.0),
      color: Colors.black26,
      activeSize: const Size(22.0, 10.0),
      activeColor: Color(0xff2a87ef),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff2a87ef),
      ),
      bodyTextStyle: TextStyle(
        fontSize: 20.0,
        color: Color(0xff2a87ef),
      ),
      imagePadding: EdgeInsets.all(24.0),
      pageColor: Colors.white,
    );
  }
}
