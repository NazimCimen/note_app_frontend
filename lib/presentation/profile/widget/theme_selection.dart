import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/config/theme/theme_cubit.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final themeCubit = context.read<ThemeCubit>();

        final themeOptions = [StringConstants.lightTheme, StringConstants.darkTheme];
        final currentThemeName = state.currentThemeEnum == ThemeEnum.light 
            ? StringConstants.lightTheme 
            : StringConstants.darkTheme;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.palette_outlined,
                    size: 18.w,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    StringConstants.theme,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: themeOptions.map((themeOption) {
                  final isSelected = themeOption == currentThemeName;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final themeEnum = themeOption == StringConstants.lightTheme 
                            ? ThemeEnum.light 
                            : ThemeEnum.dark;
                        await themeCubit.changeTheme(themeEnum);
                      },
                  child: Container(
                    margin: EdgeInsets.only(right: 6.w),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.outline.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          themeOption == StringConstants.lightTheme
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          size: 20.w,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          themeOption,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface.withValues(alpha: 0.7),
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
