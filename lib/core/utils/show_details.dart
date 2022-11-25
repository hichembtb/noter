import 'package:flutter/material.dart';
import 'package:noter/core/utils/size_config.dart';
import '../constants/colors/app_color.dart';

showDetails(String name, String date, String details, context) {
  return showDialog(
    context: context,
    builder: (context) {
      SizeConfig().init(context);
      return AlertDialog(
        backgroundColor: AppColor.kWhiteColor,
        title: Text("$name  Details"),
        content: SizedBox(
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date : $date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize! * 2,
                  ),
                ),
                Text(
                  details,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.defaultSize! * 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
