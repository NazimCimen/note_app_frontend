import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/core/utils/size/constant_size.dart';

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
            width: context.cXLargeValue,
            height: context.cXLargeValue,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryColor,
              ),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.2),
            ),
          ),
          SizedBox(height: context.cMediumValue),
    
          Text(
            StringConstants.socialLoginLoadingMessage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.cSmallValue),
    
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
