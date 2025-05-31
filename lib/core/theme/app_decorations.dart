import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable decorations for consistent UI styling
class AppDecorations {
  // Card Decorations
  static BoxDecoration softCard = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryNavy.withOpacity(0.08),
        offset: const Offset(0, 4),
        blurRadius: 24,
        spreadRadius: 0,
      ),
    ],
  );
  
  static BoxDecoration elevatedCard = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryNavy.withOpacity(0.12),
        offset: const Offset(0, 8),
        blurRadius: 32,
        spreadRadius: 0,
      ),
    ],
  );
  
  static BoxDecoration glassCard = BoxDecoration(
    color: AppColors.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: AppColors.white.withOpacity(0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryNavy.withOpacity(0.08),
        offset: const Offset(0, 4),
        blurRadius: 24,
        spreadRadius: 0,
      ),
    ],
  );
  
  // Input Field Decorations
  static InputDecoration textFieldDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.lightGray,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.darkGray,
        fontSize: 14,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryMint, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
  
  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryMint,
    foregroundColor: AppColors.primaryNavy,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );
  
  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightGray,
    foregroundColor: AppColors.primaryNavy,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );
  
  static ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryNavy,
    side: const BorderSide(color: AppColors.primaryMint, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );
  
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryNavy,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
  
  // Container Decorations
  static BoxDecoration gradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.mintLight,
        AppColors.white,
      ],
    ),
  );
  
  static BoxDecoration primaryGradientDecoration = BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(16),
  );
  
  // Border Radius
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius extraLargeRadius = BorderRadius.all(Radius.circular(24));
  
  // Shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: AppColors.primaryNavy.withOpacity(0.08),
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: AppColors.primaryNavy.withOpacity(0.12),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> largeShadow = [
    BoxShadow(
      color: AppColors.primaryNavy.withOpacity(0.16),
      offset: const Offset(0, 12),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];
}