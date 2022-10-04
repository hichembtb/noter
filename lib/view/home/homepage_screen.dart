import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noter/core/constants/colors/app_color.dart';
import 'package:noter/core/controllers/homepage_controller.dart';
import 'package:noter/core/utils/size_config.dart';

import '../../models/client_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(160),
          ),
          child: Drawer(
            elevation: 0.0,
            width: SizeConfig.screenWidth! / 2.5,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: SizeConfig.screenWidth! / 2.5,
                    // height: SizeConfig.screenHeight! / 3,
                    color: AppColor.kAppBarColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.person,
                          size: SizeConfig.screenWidth! / 4,
                          color: AppColor.kMainBackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '${homePageController.currentUser!.email}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homePageController.navToAdd();
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
              homePageController.signout();
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
        title: const Text("Home Page"),
      ),
      body: GetBuilder<HomePageController>(
        builder: ((controller) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: homePageController.fetchClients,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: homePageController.clientInstance.length,
                  itemBuilder: (context, index) {
                    ClientModel client =
                        homePageController.clientInstance[index];
                    return GestureDetector(
                      onTap: () => homePageController.showTapSnackbar(),
                      onLongPress: () => homePageController.deleteClient(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Card(
                          color: index % 2 == 0
                              ? AppColor.kEvenIndexColor
                              : AppColor.kOddIndexColor,
                          child: ListTile(
                            trailing: Text('${client.credit}'),
                            leading: IconButton(
                              onPressed: () {
                                homePageController.navToView(
                                  client.name,
                                  client.surname,
                                  client.credit,
                                  client.payment,
                                );
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
          );
        }),
      ),
    );
  }
}
