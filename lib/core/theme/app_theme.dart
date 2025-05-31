import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_decorations.dart';

/// Main theme configuration for the School Management App
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryMint,
      secondary: AppColors.primaryNavy,
      surface: AppColors.white,
      background: AppColors.offWhite,
      error: AppColors.error,
      onPrimary: AppColors.primaryNavy,
      onSecondary: AppColors.white,
      onSurface: AppColors.charcoal,
      onBackground: AppColors.charcoal,
      onError: AppColors.white,
    ),
    
    // Scaffold Background
    scaffoldBackgroundColor: AppColors.offWhite,
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTextStyles.h3,
      iconTheme: const IconThemeData(
        color: AppColors.primaryNavy,
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.white,
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppDecorations.primaryButtonStyle,
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppDecorations.outlineButtonStyle,
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: AppDecorations.textButtonStyle,
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGray,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.primaryNavy,
      size: 24,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryNavy,
      unselectedItemColor: AppColors.darkGray,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightGray,
      selectedColor: AppColors.primaryMint,
      disabledColor: AppColors.mediumGray,
      labelStyle: AppTextStyles.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    
    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.white,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primaryNavy,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryMint,
      linearTrackColor: AppColors.lightGray,
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryMint;
        }
        return AppColors.darkGray;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryMint.withOpacity(0.5);
        }
        return AppColors.mediumGray;
      }),
    ),
    
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryMint;
        }
        return Colors.transparent;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primaryMint;
        }
        return AppColors.darkGray;
      }),
    ),
    
    // Page Transitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
  
  // Dark theme can be added here if needed
  static ThemeData darkTheme = lightTheme; // For now, using light theme
}