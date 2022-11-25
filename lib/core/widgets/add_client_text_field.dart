import 'package:flutter/material.dart';
import '../constants/colors/app_color.dart';

class AddClientTextField extends StatelessWidget {
  const AddClientTextField({
    Key? key,
    required this.validator,
    required this.onSaved,
    required this.labelText,
    required this.keyboardType,
    required this.icon,
    this.maxLines,
  }) : super(key: key);
  //
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? labelText;
  final IconData icon;
  final int? maxLines;
  final TextInputType? keyboardType;
  //
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
