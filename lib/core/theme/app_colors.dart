import 'package:flutter/material.dart';

/// App color palette following the design system
/// Primary: #9eefe1 (Soft mint green)
/// Secondary: #1b4664 (Deep navy)
class AppColors {
  // Primary Colors
  static const Color primaryMint = Color(0xFF9EEFE1);      // #9eefe1 - Main brand color
  static const Color primaryNavy = Color(0xFF1B4664);      // #1b4664 - Secondary brand color
  
  // Tonal Variations
  static const Color mintLight = Color(0xFFE8FCF8);        // Light mint for backgrounds
  static const Color mintSoft = Color(0xFFD1F7EF);         // Soft mint for subtle accents
  static const Color navyLight = Color(0xFF4A6B85);        // Light navy for text
  static const Color navyDark = Color(0xFF0F2A3D);         // Dark navy for emphasis
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFBFC);
  static const Color lightGray = Color(0xFFF5F6F8);
  static const Color mediumGray = Color(0xFFE1E5E9);
  static const Color darkGray = Color(0xFF6B7280);
  static const Color charcoal = Color(0xFF374151);
  static const Color black = Color(0xFF000000);
  
  // Semantic Colors
  static const Color success = Color(0xFF10B981);          // Green for success states
  static const Color warning = Color(0xFFF59E0B);          // Amber for warnings
  static const Color error = Color(0xFFEF4444);            // Red for errors
  static const Color info = Color(0xFF3B82F6);             // Blue for information
  
  // Additional UI Colors
  static const Color divider = Color(0xFFE5E7EB);
  static const Color disabled = Color(0xFF9CA3AF);
  static const Color overlay = Color(0x1F000000);          // 12% black overlay
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryMint, mintSoft],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient navyGradient = LinearGradient(
    colors: [primaryNavy, navyLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [mintLight, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}