import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class UserInfo extends StatelessWidget {
  final String email;
  final String username;
  
  const UserInfo({
    super.key,
    required this.email,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Header with icon and title
          Row(
            children: [
              Icon(
                Icons.person_outlined,
                size: 18.w,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              SizedBox(width: 8.w),
              Text(
                StringConstants.personalInfo,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Email Field (Read-only)
          _UserInfoField(
            label: StringConstants.email,
            icon: Icons.email_outlined,
            value: email,
          ),

          SizedBox(height: 16.h),

          // Username Field
          _UserInfoField(
            label: StringConstants.username,
            icon: Icons.person_outline,
            value: username,
          ),

          SizedBox(height: 16.h),

          // Password Field
          _UserInfoField(
            label: StringConstants.password,
            icon: Icons.lock_outline,
            value: '••••••••',
            isPassword: true,
          ),
        ],
      ),
    );
  }
}

class _UserInfoField extends StatelessWidget {
  const _UserInfoField({
    required this.label,
    required this.icon,
    required this.value,
    this.isPassword = false,
  });

  final String label;
  final IconData icon;
  final String value;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 42.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.w,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  isPassword ? '••••••••' : value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
