import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/routes/app_routes.dart';
import 'package:noter/core/utils/show_details.dart';
import 'package:noter/models/client_model.dart';

class HomePageController extends GetxController {
  late dynamic addedDate;
  // Sign out
  signout() async {
    await FirebaseAuth.instance.signOut();
    Get.delete<HomePageController>();
    Get.offAllNamed(AppRoute.login);
  }

// ! Navigation Function
  navToAdd() {
    Get.toNamed(AppRoute.addclient);
    Get.delete<HomePageController>();
  }

  navToView(String name, String surname, double credit, List payment,
      String details) {
    Get.toNamed(AppRoute.viewclient, arguments: {
      "name": name,
      "surname": surname,
      "credit": credit,
      "payment": payment,
      "details": details,
    });
    Get.delete<HomePageController>();
  }

  showDetailsDialog(
      String name, String date, String details, BuildContext context) {
    showDetails(name, date, details, context);
  }

  // ! Variable For Function Fetch Client
  CollectionReference clientRef =
      FirebaseFirestore.instance.collection('clients');
  List<ClientModel> clientInstance = [];
  List<QueryDocumentSnapshot<Object?>> clientDocs = [];
  User? currentUser = FirebaseAuth.instance.currentUser!;

  // ! Fetch Client Func
  Future fetchClients() async {
    clientInstance.clear();
    QuerySnapshot<Object?> clientQuery =
        await clientRef.where('refId', isEqualTo: currentUser!.uid).get();
    clientDocs = clientQuery.docs;
    for (QueryDocumentSnapshot<Object?> client in clientDocs) {
      Map<String, dynamic> clientData = client.data() as Map<String, dynamic>;
      clientInstance.add(ClientModel.fromMap(clientData));

      update();
    }
  }

  showTapSnackbar() {
    Get.bottomSheet(
      backgroundColor: Colors.black.withOpacity(0.5),
      barrierColor: Colors.transparent,
      const Text(
        'Long Tap to Delete The Client',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Future deleteClient(int index) async {
    await clientRef.doc(clientDocs[index].id).delete().whenComplete(() {
      fetchClients();
      update();
    });
  }

  @override
  void onInit() {
    fetchClients();
    super.onInit();
  }
}
