import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';

import '../constants/colors/app_color.dart';
import '../utils/show_loading.dart';

class SignUpController extends GetxController {
  late String userName;
  late String email;
  late String password;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  signup(BuildContext context) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        try {
          showLoading(context);
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
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Internet Problem "),
                content: Container(
                  height: 50,
                ),
              );
            },
          );
        }
      }
    }
  }

  signupAndNavigate(BuildContext context) async {
    var signUpres = await signup(context);
    if (signUpres != null) {
      await FirebaseFirestore.instance.collection("users").add(
        {
          "username": userName,
          "email": email,
        },
      );
      Get.offAllNamed(AppRoute.homepage);
      Get.delete<SignUpController>();
    }
  }

  switchToLogin() {
    Get.offAllNamed(AppRoute.login);
    Get.delete<SignUpController>();
  }
}
