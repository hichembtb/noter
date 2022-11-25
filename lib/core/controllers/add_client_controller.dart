import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import '../utils/show_loading.dart';

class AddClientController extends GetxController {
  late String name;
  late String surname;
  late String details;
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
          'details': details,
          'date': DateTime.now().toString(),
          'refId': FirebaseAuth.instance.currentUser!.uid,
          'payment': [],
        }).then(
          (value) {
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
