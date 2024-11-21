import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import "package:loading_animation_widget/loading_animation_widget.dart";

organoSnackBar({required String message}) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      backgroundColor: const Color(0xff0154c8),
      animationDuration: const Duration(milliseconds: 300),
      onTap: (bar) {
        Get.back();
      },
      shouldIconPulse: false,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
    ),
  );
}

void printApiResponse(String text) {
  print('\x1B[33m$text');
}

void showConfirmationDialog({
  required String dialogTitle,
  required String dialogMiddleText,
  required Function() dialogConfirm,
  required Function() dialogCancel,
}) {
  Get.defaultDialog(
    title: dialogTitle,
    middleText: dialogMiddleText,
    textConfirm: "Yes",
    textCancel: "No",
    onConfirm: dialogConfirm,
    onCancel: dialogCancel,
  );
}

// getLoading({Color color = const Color(0xff2a87ef), double size = 30}) {
//   return Center(
//     child: LoadingAnimationWidget.stretchedDots(color: color, size: size),
//   );
// }
