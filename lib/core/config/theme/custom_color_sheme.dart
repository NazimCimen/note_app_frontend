import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomColorScheme {
  const CustomColorScheme._();
  static ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.primaryColorSoft,
    onSecondary: Colors.white,
    surface: AppColors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    outline: AppColors.greyShade200,
    outlineVariant: AppColors.grey600,
  );

  static ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.primaryColorSoft,
    onSecondary: Colors.white,
    surface: const Color(0xff1F1F1F),
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    outline: AppColors.grey600,
    outlineVariant: AppColors.greyShade200,
  );
}
