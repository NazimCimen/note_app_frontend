import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/core/utils/size/app_border_radius_extensions.dart';
import 'package:flutter_note_app/core/utils/size/constant_size.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _hideCurrentSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: ValueKey('success_${DateTime.now().millisecondsSinceEpoch}'),
        content: Text(message),
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
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Kapat',
          textColor: Colors.white,
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
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Kapat',
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
        content: Text(message),
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
