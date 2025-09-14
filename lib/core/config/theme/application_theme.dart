import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter_note_app/core/config/theme/custom_color_sheme.dart';
import 'package:flutter_note_app/core/config/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ApplicationTheme {
  ThemeData get themeData;
  ColorScheme get colorScheme;
}

/// Custom light theme for project design
final class CustomLightTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.lightScheme;
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    fontFamily: 'EuclidCircularA',
    colorScheme: CustomColorScheme.lightScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _buildLightTextTheme(),
    sliderTheme: SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: Colors.grey.shade300,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.2),
      trackHeight: 4,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );

  /// Build light text theme
  TextTheme _buildLightTextTheme() {
    return TextTheme(
      displayLarge: AppTextTheme.displayLarge,
      displayMedium: AppTextTheme.displayMedium,
      displaySmall: AppTextTheme.displaySmall,
      headlineLarge: AppTextTheme.headlineLarge,
      headlineMedium: AppTextTheme.headlineMedium,
      headlineSmall: AppTextTheme.headlineSmall,
      titleLarge: AppTextTheme.titleLarge,
      titleMedium: AppTextTheme.titleMedium,
      titleSmall: AppTextTheme.titleSmall,
      bodyLarge: AppTextTheme.bodyLarge,
      bodyMedium: AppTextTheme.bodyMedium,
      bodySmall: AppTextTheme.bodySmall,
      labelLarge: AppTextTheme.labelLarge,
      labelMedium: AppTextTheme.labelMedium,
      labelSmall: AppTextTheme.labelSmall,
    );
  }
}

/// Custom Dark theme for project design
final class CustomDarkTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.darkScheme;
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    colorScheme: CustomColorScheme.darkScheme,
    fontFamily: 'EuclidCircularA',
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: _buildDarkTextTheme(),
    sliderTheme: SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: Colors.grey.shade300,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.2),
      trackHeight: 4,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF121212)),
  );

  /// Build dark text theme
  TextTheme _buildDarkTextTheme() {
    return TextTheme(
      displayLarge: AppTextTheme.displayLarge.copyWith(color: Colors.white),
      displayMedium: AppTextTheme.displayMedium.copyWith(color: Colors.white),
      displaySmall: AppTextTheme.displaySmall.copyWith(color: Colors.white),
      headlineLarge: AppTextTheme.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: AppTextTheme.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: AppTextTheme.headlineSmall.copyWith(color: Colors.white),
      titleLarge: AppTextTheme.titleLarge.copyWith(color: Colors.white),
      titleMedium: AppTextTheme.titleMedium.copyWith(color: Colors.white),
      titleSmall: AppTextTheme.titleSmall.copyWith(color: Colors.white),
      bodyLarge: AppTextTheme.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: AppTextTheme.bodyMedium.copyWith(color: Colors.white),
      bodySmall: AppTextTheme.bodySmall.copyWith(color: Colors.grey[400]),
      labelLarge: AppTextTheme.labelLarge.copyWith(color: Colors.white),
      labelMedium: AppTextTheme.labelMedium.copyWith(color: Colors.white),
      labelSmall: AppTextTheme.labelSmall.copyWith(color: Colors.grey[400]),
    );
  }
}
