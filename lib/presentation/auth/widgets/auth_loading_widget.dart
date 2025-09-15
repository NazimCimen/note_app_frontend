import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Loading widget for auth operations
class AuthLoadingWidget extends StatelessWidget {
  const AuthLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.2),
            ),
          ),
          SizedBox(height: 16.h),

          Text(
            StringConstants.socialLoginLoadingMessage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          Text(
            'Lütfen bekleyin...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
