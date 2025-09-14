import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom text theme for the application
/// Provides consistent typography across the app
@immutable
final class AppTextTheme {
  const AppTextTheme._();

  /// Display styles - Large headings
  static TextStyle get displayLarge =>
      TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w400);

  static TextStyle get displayMedium =>
      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w400);

  static TextStyle get displaySmall =>
      TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w400);

  /// Headline styles - Section headings
  static TextStyle get headlineLarge =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600);

  static TextStyle get headlineMedium =>
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600);

  static TextStyle get headlineSmall =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600);

  /// Title styles - Card titles, dialog titles
  static TextStyle get titleLarge =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600);

  static TextStyle get titleMedium =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);

  static TextStyle get titleSmall =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  /// Body styles - Main content text
  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);

  static TextStyle get bodySmall =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);

  /// Label styles - Buttons, labels, captions
  static TextStyle get labelLarge =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  static TextStyle get labelMedium =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);

  static TextStyle get labelSmall =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);
}
