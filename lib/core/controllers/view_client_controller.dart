import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/colors/app_color.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import 'package:noter/core/utils/show_loading.dart';

class ViewClientController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String? name;
  String? surname;
  double? credit;
  double? newCredit;
  double? newPayment;
  List? payment;
  @override
  void onInit() {
    name = Get.arguments['name'];
    surname = Get.arguments['surname'];
    credit = Get.arguments['credit'];
    payment = Get.arguments['payment'];
    super.onInit();
  }

  // ? Firebase Variable
  CollectionReference clientRef =
      FirebaseFirestore.instance.collection('clients');
  Future addCredit(
      BuildContext context, String name, String surname, double credit) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        showLoading(context);
        if (newCredit == 0 && newPayment == 0) {
          Get.offAllNamed(AppRoute.homepage);
          Get.delete<ViewClientController>();
        } else {
          QuerySnapshot<Object?> clientQuery = await clientRef
              .where('name', isEqualTo: name)
              .where('surname', isEqualTo: surname)
              .where('credit', isEqualTo: credit)
              .get();
          List<QueryDocumentSnapshot<Object?>> clientDocs = clientQuery.docs;
          for (QueryDocumentSnapshot<Object?> client in clientDocs) {
            if (newCredit != 0) {
              clientRef
                  .doc(client.id)
                  .update({"credit": credit + newCredit!}).whenComplete(
                () {
                  Get.snackbar(
                    'Alert',
                    'please refresh the page to update your data',
                    colorText: AppColor.kButtonColor,
                    duration: const Duration(seconds: 5),
                  );
                  Get.offAllNamed(AppRoute.homepage);
                  Get.delete<ViewClientController>();
                },
              );
            } else {
              Get.offAllNamed(AppRoute.homepage);
              Get.delete<ViewClientController>();
            }

            update();
          }
        }
      }
    }
  }

  Future addPayment(
      BuildContext context, String name, String surname, double credit) async {
    var formdata = formstate.currentState;
    if (formdata != null) {
      if (formdata.validate()) {
        formdata.save();
        showLoading(context);
        QuerySnapshot<Object?> clientQuery = await clientRef
            .where('name', isEqualTo: name)
            .where('surname', isEqualTo: surname)
            .where('credit', isEqualTo: credit)
            .get();
        List<QueryDocumentSnapshot<Object?>> clientDocs = clientQuery.docs;
        for (QueryDocumentSnapshot<Object?> client in clientDocs) {
          if (newPayment != 0) {
            payment!.add(newPayment);
            clientRef.doc(client.id).update({
              "payment": payment,
            }).whenComplete(
              () {
                clientRef
                    .doc(client.id)
                    .update({"credit": credit - newPayment!});
                Get.snackbar(
                  'Alert',
                  'please refresh the page to update your data',
                  colorText: AppColor.kButtonColor,
                  duration: const Duration(seconds: 5),
                );
                Get.offAllNamed(AppRoute.homepage);
                Get.delete<ViewClientController>();
              },
            );
          } else {
            Get.offAllNamed(AppRoute.homepage);
            Get.delete<ViewClientController>();
          }

          update();
        }
      }
    }
  }
}
