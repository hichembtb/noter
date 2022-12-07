import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import '../services/loading_service.dart';

class ViewClientController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String? name;
  String? surname;
  String? details;
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
    details = Get.arguments['details'];
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
        LoadingService().showLoading();
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
              clientRef.doc(client.id).update({
                "credit": credit + newCredit!,
                "details": details,
              }).whenComplete(
                () {
                  LoadingService().dismissLoading();
                  Get.offAllNamed(AppRoute.homepage);
                  Get.delete<ViewClientController>();
                },
              );
            } else {
              LoadingService().dismissLoading();
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
        LoadingService().showLoading();
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
              "details": details,
            }).whenComplete(
              () {
                clientRef.doc(client.id).update({
                  "credit": credit - newPayment!,
                  "details": details,
                });
                LoadingService().dismissLoading();
                Get.offAllNamed(AppRoute.homepage);
                Get.delete<ViewClientController>();
              },
            );
          } else {
            LoadingService().dismissLoading();
            Get.offAllNamed(AppRoute.homepage);
            Get.delete<ViewClientController>();
          }

          update();
        }
      }
    }
  }
}
