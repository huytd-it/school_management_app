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
  
  // Role-based Colors
  static const Color adminColor = Color(0xFFFF6B6B);       // Red for admin
  static const Color teacherColor = Color(0xFF4ECDC4);     // Teal for teacher
  static const Color studentColor = Color(0xFF45B7D1);     // Blue for student
  static const Color parentColor = Color(0xFFFF9F43);      // Orange for parent
  
  // Priority Colors
  static const Color high = Color(0xFFDC2626);             // High priority - Red
  static const Color medium = Color(0xFFF59E0B);           // Medium priority - Orange
  static const Color low = Color(0xFF059669);              // Low priority - Green
  
  // Status Colors
  static const Color active = Color(0xFF10B981);
  static const Color inactive = Color(0xFF6B7280);
  static const Color pending = Color(0xFFF59E0B);
  static const Color archived = Color(0xFF9CA3AF);
  
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
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [white, offWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadow Colors
  static const Color shadowLight = Color(0x0A000000);      // 4% opacity
  static const Color shadowMedium = Color(0x14000000);     // 8% opacity
  static const Color shadowDark = Color(0x1F000000);       // 12% opacity
  
  // Utility methods
  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Get role-based color
  static Color getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
      case 'super_admin':
        return adminColor;
      case 'teacher':
        return teacherColor;
      case 'student':
        return studentColor;
      case 'parent':
        return parentColor;
      default:
        return darkGray;
    }
  }
  
  /// Get priority color
  static Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return high;
      case 'medium':
        return medium;
      case 'low':
        return low;
      default:
        return darkGray;
    }
  }
  
  /// Get status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
      case 'completed':
        return active;
      case 'inactive':
      case 'disabled':
        return inactive;
      case 'pending':
      case 'processing':
        return pending;
      case 'archived':
      case 'deleted':
        return archived;
      default:
        return darkGray;
    }
  }
  
  /// Color schemes for light and dark modes
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryMint,
    onPrimary: primaryNavy,
    secondary: primaryNavy,
    onSecondary: white,
    tertiary: mintSoft,
    onTertiary: charcoal,
    error: error,
    onError: white,
    surface: white,
    onSurface: charcoal,
    background: offWhite,
    onBackground: charcoal,
    outline: mediumGray,
    shadow: shadowMedium,
  );
  
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryMint,
    onPrimary: navyDark,
    secondary: navyLight,
    onSecondary: white,
    tertiary: mintSoft,
    onTertiary: white,
    error: error,
    onError: white,
    surface: navyDark,
    onSurface: white,
    background: black,
    onBackground: white,
    outline: darkGray,
    shadow: shadowDark,
  );
}