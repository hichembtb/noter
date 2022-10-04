import 'package:flutter/material.dart';
import '../constants/colors/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? inputType;

  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final String hintText;
  final IconData prefixIcon;
  final TextStyle? hintStyle;

  const CustomTextFormField({
    Key? key,
    @required this.inputType,
    @required this.onSaved,
    this.onChanged,
    this.maxLines,
    this.validator,
    this.controller,
    this.hintStyle,
    required this.obscureText,
    required this.hintText,
    required this.prefixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.kFillTextFieldColor,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColor.kButtonColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.kButtonColor),
        ),
      ),
    );
  }
}
