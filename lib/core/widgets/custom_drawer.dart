import 'package:flutter/material.dart';
import 'package:noter/core/configuration/size_config.dart';
import '../constants/colors/app_color.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.userEmail});
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
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
                        userEmail,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize! * 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
