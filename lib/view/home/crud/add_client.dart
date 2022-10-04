import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noter/core/controllers/add_client_controller.dart';
import '../../../core/constants/colors/app_color.dart';
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
          // physics: const NeverScrollableScrollPhysics(),
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
                    icon: Icons.person,
                    validator: (val) {
                      if (val!.length > 22) {
                        return "less then 22 pls";
                      }
                      if (val.length < 2) {
                        return "more then 2";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      addClientController.name = val!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AddClientTextField(
                    labelText: 'Surname',
                    icon: Icons.family_restroom,
                    validator: (val) {
                      if (val!.length > 22) {
                        return "less then 22 pls";
                      }
                      if (val.length < 2) {
                        return "more then 2";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      addClientController.surname = val!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AddClientTextField(
                    labelText: 'Credit',
                    icon: Icons.money,
                    validator: (val) {
                      if (val!.length > 22) {
                        return "less then 22 pls";
                      }
                      if (val.length < 2) {
                        return "more then 2";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      addClientController.credit = double.parse(val!);
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

class AddClientTextField extends StatelessWidget {
  const AddClientTextField({
    Key? key,
    required this.validator,
    required this.onSaved,
    required this.labelText,
    required this.icon,
  }) : super(key: key);
  //
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? labelText;
  final IconData icon;
  //
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      inputFormatters: [
        LengthLimitingTextInputFormatter(22),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: AppColor.kButtonColor,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
