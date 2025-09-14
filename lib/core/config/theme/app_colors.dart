import 'package:flutter/material.dart';

@immutable
final class AppColors {
  static const Color primaryColor = Color(0xffFFAD00);
  static const Color primaryColorSoft = Color(0xff769bca);
  static const Color background = Color(0xfff4f4f4);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static Color grey600 = Colors.grey[600]!;
  static Color greyShade200 = Colors.grey.shade200;
  static const Color blackOutline = Colors.black54;
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  
  // Snack Bar Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color infoColor = Color(0xFF3B82F6);
  static const Color warningColor = Color(0xFFF59E0B);
  
  // Snack Bar Background Colors
  static const Color successBackgroundColor = Color(0xFFF0FDF4);
  static const Color errorBackgroundColor = Color(0xFFFEF2F2);
  static const Color infoBackgroundColor = Color(0xFFEFF6FF);
  static const Color warningBackgroundColor = Color(0xFFFFFBEB);
  
  // Snack Bar Text Colors
  static const Color successTextColor = Color(0xFF065F46);
  static const Color errorTextColor = Color(0xFF991B1B);
  static const Color infoTextColor = Color(0xFF1E40AF);
  static const Color warningTextColor = Color(0xFF92400E);
  
  // Premium Banner Colors
  static const Color premiumGradientStart = Color(0xFF667eea);
  static const Color premiumGradientEnd = Color(0xFF764ba2);
  static const Color premiumAccent = Color(0xFFffd700);
  
  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A000000);
  static const Color cardBorder = Color(0xFFE5E7EB);
  
  // Search & Filter Colors
  static const Color searchBackground = Color(0xFFF9FAFB);
  static const Color searchBorder = Color(0xFFD1D5DB);
  static const Color filterChipBackground = Color(0xFFF3F4F6);
  static const Color filterChipSelected = Color(0xFF3B82F6);
  
  // Note Colors
  static const Color noteBackground = Color(0xFFFFFFFF);
  static const Color noteBorder = Color(0xFFE5E7EB);
  static const Color favoriteColor = Color(0xFFEF4444);
  static const Color noteText = Color(0xFF374151);
  static const Color noteSubtext = Color(0xFF6B7280);
  
  // Profile Colors
  static const Color profileBackground = Color(0xFFF8FAFC);
  static const Color profileCard = Color(0xFFFFFFFF);
  static const Color profileDivider = Color(0xFFE2E8F0);
}
