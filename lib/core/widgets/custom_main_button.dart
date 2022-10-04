import 'package:flutter/material.dart';

import '../constants/colors/app_color.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({
    Key? key, required this.onPressed, required this.actionText,
  }) : super(key: key);
final  void Function()? onPressed;
final String actionText ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.kButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child:  Text(
        actionText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}