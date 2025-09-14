import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/core/utils/size/app_border_radius_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputDecoration {
  CustomInputDecoration._();

  // Minimal phone field decoration for modern look
  static InputDecoration phoneFieldDecoration({
    required BuildContext context,
    required String hintText,
  }) => InputDecoration(
    fillColor: Theme.of(context).colorScheme.surface,
    filled: true,
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
    ),
  );

  static InputDecoration inputAuthDecoration({
    required BuildContext context,
    required String hintText,
    String? prefixIconPath,
    String? prefixText,

    bool? isPassword,
    VoidCallback? changeObsecureText,
    bool? obsecureText,
  }) => InputDecoration(
    fillColor: Theme.of(context).colorScheme.surface,
    filled: true,
    prefixIcon: prefixIconPath != null
        ? Image.asset(
            prefixIconPath,
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.7),
          )
        : null,
    prefixText: prefixText,
    prefixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: Theme.of(
        context,
      ).colorScheme.outlineVariant.withValues(alpha: 0.8),
      fontFamily: GoogleFonts.montserrat().fontFamily,
    ),
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w400,
      color: Theme.of(
        context,
      ).colorScheme.outlineVariant.withValues(alpha: 0.8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: context.cBorderRadiusAllMedium,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
    ),
    suffixIcon: isPassword ?? false
        ? IconButton(
            onPressed: changeObsecureText ?? () {},
            icon: Icon(
              obsecureText ?? false ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.8),
            ),
          )
        : null,
  );
}
