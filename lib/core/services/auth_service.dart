import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/services/loading_service.dart';
import '../constants/colors/app_color.dart';

class AuthService {
  // ! login Methode
  Future loginwithEmailandPassword(
      BuildContext context, String userEmail, String userPassword) async {
    try {
      LoadingService().showLoading();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.back();
      e.code == 'user-not-found'
          ? AwesomeDialog(
              context: context,
              title: "Error",
              desc: 'no user found for that email.',
              descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              dialogBackgroundColor: AppColor.kButtonColor.withOpacity(0.8),
            ).show()
          : null;

      e.code == 'wrong-password'
          ? AwesomeDialog(
              context: context,
              title: "Error",
              desc: 'Wrong password provided for that user.',
              descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              dialogBackgroundColor: AppColor.kButtonColor.withOpacity(0.8),
            ).show()
          : null;
    } catch (e) {
      return LoadingService().showError("Internet Problem ");
    }
  }

  // ! Sign up methode
  Future signupwithEmailandPassword(
      BuildContext context, String email, String password) async {
    try {
      LoadingService().showLoading();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      e.code == 'weak-password'
          ? AwesomeDialog(
              width: double.infinity,
              context: context,
              title: "Error",
              desc: 'The password provided is too weak.',
              descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              dialogBackgroundColor: AppColor.kButtonColor.withOpacity(0.8),
            ).show()
          : null;
      e.code == 'email-already-in-use'
          ? AwesomeDialog(
              width: double.infinity,
              context: context,
              title: "Error",
              desc: 'The account already exists for that email.',
              descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              dialogBackgroundColor: AppColor.kButtonColor.withOpacity(0.8),
            ).show()
          : null;
    } catch (e) {
      return LoadingService().showError("Internet Problem ");
    }
  }
}
