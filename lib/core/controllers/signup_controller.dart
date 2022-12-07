import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import 'package:noter/core/services/auth_service.dart';

import '../services/loading_service.dart';

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
        await AuthService()
            .signupwithEmailandPassword(context, email, password);
        await FirebaseFirestore.instance.collection("users").add(
          {
            "username": userName,
            "email": email,
          },
        );
        LoadingService().dismissLoading();
        Get.offAllNamed(AppRoute.homepage);
        Get.delete<SignUpController>();
      }
    }
  }

  switchToLogin() {
    Get.offAllNamed(AppRoute.login);
    Get.delete<SignUpController>();
  }
}
