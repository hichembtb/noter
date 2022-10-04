import 'package:flutter/material.dart';

import '../constants/colors/app_color.dart';

showLoading(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.kButtonColor.withOpacity(0.8),
        title: const Text("Please wait"),
        content: const SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
