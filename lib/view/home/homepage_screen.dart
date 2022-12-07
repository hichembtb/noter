import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/colors/app_color.dart';
import 'package:noter/core/controllers/homepage_controller.dart';
import 'package:noter/core/configuration/size_config.dart';
import 'package:noter/core/widgets/custom_drawer.dart';

import '../../models/client_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
              drawer: CustomDrawer(
                userEmail: "${controller.currentUser!.email}",
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.navToAdd();
                },
                backgroundColor: AppColor.kButtonColor,
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 35,
                backgroundColor: AppColor.kAppBarColor,
                actions: [
                  IconButton(
                    onPressed: () async {
                      controller.signout();
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                  ),
                ],
                title: const Text("Home Page"),
              ),
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: controller.fetchClients,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: controller.clientInstance.length,
                      itemBuilder: (context, index) {
                        ClientModel client = controller.clientInstance[index];
                        DateTime dte = controller.addedDate = DateTime.parse(
                            controller.clientInstance[index].date);

                        return GestureDetector(
                          onTap: () => controller.showDetailsDialog(
                              client.name,
                              '${dte.day}/${dte.month}/${dte.year}',
                              client.details,
                              context),
                          onDoubleTap: () => controller.showTapSnackbar(),
                          onLongPress: () => controller.deleteClient(index),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Card(
                              color: index % 2 == 0
                                  ? AppColor.kEvenIndexColor
                                  : AppColor.kOddIndexColor,
                              child: ListTile(
                                trailing: Text('${client.credit}'),
                                leading: IconButton(
                                  onPressed: () {
                                    controller.navToView(
                                        client.name,
                                        client.surname,
                                        client.credit,
                                        client.payment,
                                        client.details);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                iconColor: AppColor.kButtonColor,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(client.name),
                                    Text(client.surname),
                                    // Text('${dte.day}/${dte.month}/${dte.year}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ));
        });
  }
}
