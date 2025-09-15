import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: ValueKey('success_${DateTime.now().millisecondsSinceEpoch}'),
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    _hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: ValueKey('error_${DateTime.now().millisecondsSinceEpoch}'),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.white,
          ),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: StringConstants.close,
          textColor: AppColors.white,
          onPressed: () => _hideCurrentSnackBar(context),
        ),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    _hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: ValueKey('warning_${DateTime.now().millisecondsSinceEpoch}'),
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: StringConstants.close,
          textColor: Colors.white,
          onPressed: () => _hideCurrentSnackBar(context),
        ),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    _hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: ValueKey('info_${DateTime.now().millisecondsSinceEpoch}'),
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void _hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void hideAllSnackBars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
