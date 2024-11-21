import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailer_app/utils/my_global_helper.dart';
import 'package:tailer_app/view/auth/login_screen.dart';
import 'package:tailer_app/view/screens/home_screens/home_screen.dart';
import 'package:tailer_app/view/screens/home_screens/pages/home_page.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool showPassword = true.obs;
  RxBool showConfPassword = true.obs;
  Future<void> signUp() async {
    if (nameController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Name");
    } else if (emailController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Email");
    } else if (phoneController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Phone");
    } else if (passwordController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Password");
    } else if (passwordController.text != confirmPasswordController.text) {
      organoSnackBar(message: 'Passwords do not match');
    } else {
      try {
        isLoading(true);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'uid': userCredential.user?.uid,
        });
        organoSnackBar(message: "Registered Successfully");
        Get.off(() => SignInScreen());
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            message = 'The account already exists for that email.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }
        organoSnackBar(message: message);
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> signIn() async {
    if (emailController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Email");
    } else if (passwordController.text.isEmpty) {
      organoSnackBar(message: "Please Enter Your Password");
    } else {
      try {
        isLoading(true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        organoSnackBar(message: "Login Successfully");
        Get.offAll(() => HomePage());
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'user-not-found':
            message = 'No user found for that email.';
            break;
          case 'wrong-password':
            message = 'Wrong password provided.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }
        organoSnackBar(message: message);
      } finally {
        isLoading(false);
      }
    }
  }
}
