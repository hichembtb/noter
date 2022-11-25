import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/controllers/add_client_controller.dart';
import 'package:noter/core/functions/validator.dart';
import '../../../core/constants/colors/app_color.dart';
import '../../../core/widgets/add_client_text_field.dart';
import '../../../core/widgets/custom_main_button.dart';

class AddClient extends StatelessWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddClientController addClientController = Get.put(AddClientController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.kMainBackColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add Client"),
          toolbarHeight: 35,
          backgroundColor: AppColor.kAppBarColor,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 8, right: 8),
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              key: addClientController.formstate,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AddClientTextField(
                    labelText: 'Name',
                    keyboardType: TextInputType.name,
                    icon: Icons.person,
                    validator: (value) => validator(value!, 3, 22, ''),
                    onSaved: (val) {
                      addClientController.name = val!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddClientTextField(
                    labelText: 'Surname',
                    keyboardType: TextInputType.name,
                    icon: Icons.family_restroom,
                    validator: (value) => validator(value!, 3, 22, ''),
                    onSaved: (val) {
                      addClientController.surname = val!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AddClientTextField(
                    labelText: 'Credit',
                    keyboardType: TextInputType.number,
                    icon: Icons.money,
                    validator: (value) => validator(value!, 1, 7, ''),
                    onSaved: (val) {
                      addClientController.credit = double.parse(val!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddClientTextField(
                    labelText: 'Details',
                    keyboardType: TextInputType.name,
                    icon: Icons.money,
                    //  obscureText: false,
                    validator: (value) => validator(value!, 10, 1000, ''),
                    onSaved: (val) {
                      addClientController.details = val!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                    actionText: 'Add Client ',
                    onPressed: () {
                      addClientController.addClient(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
