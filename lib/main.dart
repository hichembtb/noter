import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/colors/app_color.dart';
import 'package:noter/view/auth/login_screen.dart';
import 'core/constants/routes/app_pages_route.dart';
import 'view/home/homepage_screen.dart';

//
late bool isLoged;
//
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.kAppBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var userloged = FirebaseAuth.instance.currentUser;
  userloged == null ? isLoged = false : isLoged = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoged == true ? const HomePage() : const LoginScreen(),
      getPages: getPages,
    );
  }
}
