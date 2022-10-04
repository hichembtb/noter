import 'package:get/get.dart';
import 'package:noter/view/auth/login_screen.dart';
import 'package:noter/view/auth/signup_screen.dart';
import 'package:noter/view/home/crud/add_client.dart';
import 'package:noter/view/home/crud/view_client.dart';
import 'package:noter/view/home/homepage_screen.dart';

import 'app_routes.dart';

List<GetPage<dynamic>>? getPages = [
  // First Route , starting page

  // !Auth
  GetPage(name: AppRoute.signUp, page: () => const SignUpScreen()),
  GetPage(name: AppRoute.login, page: () => const LoginScreen()),
  // ? Home
  GetPage(name: AppRoute.homepage, page: () => const HomePage()),
  // ! Crud
  GetPage(name: AppRoute.addclient, page: () => const AddClient()),
  GetPage(name: AppRoute.viewclient, page: () => const ViewClient()),
];
