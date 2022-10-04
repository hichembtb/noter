import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/colors/app_color.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import '../utils/show_loading.dart';

class LoginController extends GetxController {
  late String userEmail;
  late String userPassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  login(BuildContext context) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        try {
          showLoading(context);
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userEmail,
            password: userPassword,
          );
          return userCredential;
        } on FirebaseAuthException catch (e) {
          Navigator.of(context).pop();
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

  loginAndNavigate(BuildContext context) async {
    var loginRes = await login(context);

    if (loginRes != null) {
      Get.offAllNamed(AppRoute.homepage);
      Get.delete<LoginController>();
    }
  }

  switchToSignUp() {
    Get.offAllNamed(AppRoute.signUp);
    Get.delete<LoginController>();
  }
}
