import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/config/routes/app_routes.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(
        StringConstants.profileTitle,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => _showLogoutDialog(context),
          icon: Icon(
            Icons.logout_outlined,
            size: 20.w,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        title: Text(
          StringConstants.profileLogoutTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        content: Text(
          StringConstants.profileLogoutContent,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13.sp,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              StringConstants.cancel,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              AuthLocalDataSource().clearTokens();
              context.go(AppRoutes.login);
            },
            child: Text(
              StringConstants.profileLogoutButton,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
