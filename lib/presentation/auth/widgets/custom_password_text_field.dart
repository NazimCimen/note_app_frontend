import 'package:flutter_note_app/shared/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter_note_app/core/utils/app_validators.dart';
import 'package:flutter_note_app/core/utils/enum/image_enum.dart';
import 'package:flutter/material.dart';

/// Custom password text field with visibility toggle
class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final VoidCallback? changeObsecureText;
  final String? hintText;
  const CustomPasswordTextField({
    required this.controller,
    required this.obsecureText,
    this.changeObsecureText,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => AppValidators.passwordValidator(value),
      obscureText: obsecureText,
      textInputAction: TextInputAction.done,
      decoration: CustomInputDecoration.inputAuthDecoration(
        context: context,
        hintText: hintText ?? 'Şifre',
        prefixIconPath: ImageEnums.ic_password.toPathPng,
        isPassword: changeObsecureText != null,
        changeObsecureText: changeObsecureText,
        obsecureText: obsecureText,
      ),
    );
  }
}
