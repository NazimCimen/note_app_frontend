import 'package:flutter_note_app/shared/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter/material.dart';

/// Custom text form field for auth pages
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String prefixIconPath;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  const CustomTextFormField({
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.prefixIconPath,
    required this.keyboardType,
    required this.textInputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: CustomInputDecoration.inputAuthDecoration(
        context: context,
        hintText: hintText,
        prefixIconPath: prefixIconPath,
      ),
    );
  }
}
