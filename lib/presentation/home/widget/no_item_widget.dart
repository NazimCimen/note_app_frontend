import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_outlined,
            size: 48.w,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
          ),

          SizedBox(height: 16.h),

           Text(
             StringConstants.homeNoNotesTitle,
             style: theme.textTheme.titleMedium?.copyWith(
               color: colorScheme.onSurface.withValues(alpha: 0.8),
               fontWeight: FontWeight.w500,
             ),
           ),
           SizedBox(height: 6.h),
           Text(
             StringConstants.homeNoNotesSubtitle,
             style: theme.textTheme.bodySmall?.copyWith(
               color: colorScheme.onSurface.withValues(alpha: 0.6),
             ),
           ),
           SizedBox(height: 12.h),

           TextButton.icon(
             onPressed: () => context.push(AppRoutes.createNote),
             icon: Icon(Icons.edit_outlined, size: 18.w),
             label: Text(StringConstants.homeCreateFirstNote),
             style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
           ),
        ],
      ),
    );
  }
}
