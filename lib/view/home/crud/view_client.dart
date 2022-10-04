import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/controllers/view_client_controller.dart';
import 'package:noter/core/utils/size_config.dart';
import 'package:noter/core/widgets/custom_text_formfield.dart';
import '../../../core/constants/colors/app_color.dart';

class ViewClient extends StatelessWidget {
  const ViewClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ViewClientController viewClientController = Get.put(ViewClientController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewClientController.addPayment(
            context,
            viewClientController.name!,
            viewClientController.surname!,
            viewClientController.credit!,
          );
        },
        backgroundColor: AppColor.kButtonColor,
        child: const Icon(
          Icons.attach_money,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 35,
        backgroundColor: AppColor.kAppBarColor,
        actions: [
          IconButton(
            onPressed: () {
              // add to credit Function
              viewClientController.addCredit(
                context,
                viewClientController.name!,
                viewClientController.surname!,
                viewClientController.credit!,
              );
            },
            icon: const Icon(
              Icons.addchart,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  trailing: Text(
                    '${viewClientController.credit}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.defaultSize! * 2,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewClientController.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize! * 2,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          viewClientController.surname!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize! * 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: viewClientController.formstate,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField(
                        inputType: TextInputType.number,
                        obscureText: false,
                        hintText: 'new credit',
                        hintStyle: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                        prefixIcon: Icons.money_off,
                        onSaved: (value) {
                          viewClientController.newCredit = double.parse(value);
                        },
                        validator: (value) {
                          if (value!.length > 5) {
                            return "too LONG!!! ";
                          }
                          if (value.isEmpty) {
                            return "enter value ";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextFormField(
                        inputType: TextInputType.number,
                        obscureText: false,
                        hintText: 'new payment',
                        prefixIcon: Icons.money,
                        onSaved: (value) {
                          viewClientController.newPayment = double.parse(value);
                        },
                        validator: (value) {
                          if (value!.length > 5) {
                            return "too LONG!!! ";
                          }
                          if (value.isEmpty) {
                            return "enter value ";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              viewClientController.payment!.isEmpty
                  ? const Center(
                      child: Text(
                        'No Payment yet ',
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewClientController.payment!.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${viewClientController.payment![index]} Da',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.defaultSize! * 2,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
