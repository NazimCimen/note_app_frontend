import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputDecoration {
  CustomInputDecoration._();

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
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
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
