import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import 'package:noter/core/services/auth_service.dart';
import 'package:noter/core/services/loading_service.dart';

class LoginController extends GetxController {
  late String userEmail;
  late String userPassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  login(BuildContext context) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();

        await AuthService()
            .loginwithEmailandPassword(context, userEmail, userPassword);

        LoadingService().dismissLoading();
        Get.offAllNamed(AppRoute.homepage);
        Get.delete<LoginController>();
      }
    }
  }

  switchToSignUp() {
    Get.offAllNamed(AppRoute.signUp);
    Get.delete<LoginController>();
  }
}
