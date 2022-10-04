import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';

import '../constants/colors/app_color.dart';
import '../utils/show_loading.dart';

class AddClientController extends GetxController {
  late String name;
  late String surname;
  late double credit;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference clientRef =
      FirebaseFirestore.instance.collection('clients');
  addClient(BuildContext context) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        showLoading(context);
        await clientRef.add({
          'name': name,
          'surname': surname,
          'credit': credit,
          'date': DateTime.now().toString(),
          'refId': FirebaseAuth.instance.currentUser!.uid,
          'payment': [],
        }).then(
          (value) {
            Get.snackbar(
              'Alert',
              'please refresh the page to update your data',
              colorText: AppColor.kButtonColor,
              duration: const Duration(seconds: 5),
            );
            Get.offAllNamed(AppRoute.homepage);
          },
        ).catchError(
          (error) {
            showDialog(
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
          },
        );
      }
    }
  }
}
