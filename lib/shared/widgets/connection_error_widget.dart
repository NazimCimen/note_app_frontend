import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionErrorWidget extends StatelessWidget {
  const ConnectionErrorWidget({required this.reload, super.key});
  final VoidCallback reload;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 48.w,
            color: colorScheme.error.withValues(alpha: 0.6),
          ),

          SizedBox(height: 16.h),

          Text(
            'Bağlantı sorunu',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            'Lütfen tekrar deneyin',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          TextButton.icon(
            onPressed: reload,
            icon: Icon(Icons.refresh_rounded, size: 18.w),
            label: const Text('Yeniden dene'),
            style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
