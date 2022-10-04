import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/images/app_images.dart';
import 'package:noter/core/controllers/login_controller.dart';
import 'package:noter/core/utils/size_config.dart';
import 'package:noter/core/widgets/custom_main_button.dart';
import 'package:noter/core/widgets/custom_text_formfield.dart';
import '../../core/constants/colors/app_color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColor.kMainBackColor,
      appBar: AppBar(
        backgroundColor: AppColor.kAppBarColor,
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: [
          Center(
            child: Image(
              image: const AssetImage(kLogo),
              height: SizeConfig.screenHeight! / 3,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: loginController.formstate,
              child: Column(
                children: [
                  CustomTextFormField(
                    inputType: TextInputType.emailAddress,
                    obscureText: false,
                    hintText: 'e_mail',
                    prefixIcon: Icons.email,
                    onSaved: (val) {
                      loginController.userEmail = val;
                    },
                    validator: (val) {
                      if (val!.length > 25) {
                        return "User Name too long";
                      }
                      if (val.length < 2) {
                        return "User name too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    inputType: TextInputType.text,
                    obscureText: true,
                    maxLines: 1,
                    hintText: 'password',
                    prefixIcon: Icons.lock,
                    onSaved: (val) {
                      loginController.userPassword = val;
                    },
                    validator: (val) {
                      if (val!.length > 15) {
                        return "Password Name too long";
                      }
                      if (val.length < 2) {
                        return "Password name too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("dont have an account? "),
                      InkWell(
                        onTap: () {
                          loginController.switchToSignUp();
                        },
                        child: const Text(
                          "Create one",
                          style: TextStyle(
                            color: AppColor.kButtonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomMainButton(
                    onPressed: () {
                      loginController.loginAndNavigate(context);
                    },
                    actionText: 'Login',
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
