import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/images/app_images.dart';
import 'package:noter/core/controllers/signup_controller.dart';
import 'package:noter/core/utils/size_config.dart';
import 'package:noter/core/widgets/custom_main_button.dart';
import 'package:noter/core/widgets/custom_text_formfield.dart';
import '../../core/constants/colors/app_color.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // convert to getx maybe later
    SizeConfig().init(context);
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: AppColor.kMainBackColor,
      appBar: AppBar(
        backgroundColor: AppColor.kAppBarColor,
        toolbarHeight: 0.0,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Image(
              height: SizeConfig.screenHeight! * 0.3,
              image: const AssetImage(kLogo),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: signUpController.formstate,
              child: Column(
                children: [
                  CustomTextFormField(
                    inputType: TextInputType.name,
                    hintText: 'user name',
                    obscureText: false,
                    prefixIcon: Icons.person,
                    onSaved: (val) {
                      signUpController.userName = val;
                    },
                    validator: (val) {
                      if (val!.length > 15) {
                        return "User Name too long";
                      }
                      if (val.length < 2) {
                        return "User name too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  CustomTextFormField(
                    inputType: TextInputType.emailAddress,
                    hintText: 'e-mail',
                    obscureText: false,
                    prefixIcon: Icons.email,
                    onSaved: (val) {
                      signUpController.email = val;
                    },
                    validator: (val) {
                      if (val!.length > 25) {
                        return "Email too long";
                      }
                      if (val.length < 2) {
                        return "Email too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  CustomTextFormField(
                    inputType: TextInputType.name,
                    hintText: 'password',
                    obscureText: true,
                    maxLines: 1,
                    prefixIcon: Icons.lock,
                    onSaved: (val) {
                      signUpController.password = val;
                    },
                    validator: (val) {
                      if (val!.length > 15) {
                        return "Password too long";
                      }
                      if (val.length < 2) {
                        return "Password too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("already have an account  "),
                      InkWell(
                        onTap: () {
                          signUpController.switchToLogin();
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: AppColor.kButtonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomMainButton(
                    onPressed: () {
                      signUpController.signupAndNavigate(context);
                    },
                    actionText: 'SignUp',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
