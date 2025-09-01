/// Consistent spacing and sizing dimensions for the app
/// Following 8-point grid system for pixel-perfect layouts
class AppDimensions {
  // Base unit (8dp grid system)
  static const double baseUnit = 8.0;
  
  // Spacing Scale
  static const double xs = baseUnit * 0.5;        // 4dp
  static const double sm = baseUnit * 1;          // 8dp
  static const double md = baseUnit * 2;          // 16dp
  static const double lg = baseUnit * 3;          // 24dp
  static const double xl = baseUnit * 4;          // 32dp
  static const double xxl = baseUnit * 6;         // 48dp
  static const double xxxl = baseUnit * 8;        // 64dp
  
  // Specific spacing values
  static const double paddingXS = xs;
  static const double paddingSmall = sm;
  static const double paddingMedium = md;
  static const double paddingLarge = lg;
  static const double paddingXL = xl;
  static const double paddingXXL = xxl;
  
  static const double marginXS = xs;
  static const double marginSmall = sm;
  static const double marginMedium = md;
  static const double marginLarge = lg;
  static const double marginXL = xl;
  static const double marginXXL = xxl;
  
  // Border radius scale
  static const double radiusXS = 2.0;
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusRound = 100.0;
  
  // Icon sizes
  static const double iconXS = 12.0;
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;
  
  // Avatar sizes
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 48.0;
  static const double avatarLarge = 64.0;
  static const double avatarXL = 96.0;
  static const double avatarXXL = 128.0;
  
  // Button dimensions
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeightMedium = 40.0;
  static const double buttonHeightLarge = 48.0;
  static const double buttonHeightXL = 56.0;
  
  static const double buttonPaddingHorizontal = md;
  static const double buttonPaddingVertical = sm;
  
  // Input field dimensions
  static const double inputHeight = 48.0;
  static const double inputPadding = md;
  static const double inputBorderWidth = 1.0;
  
  // Card dimensions
  static const double cardPadding = md;
  static const double cardMargin = sm;
  static const double cardElevation = 2.0;
  
  // App bar dimensions
  static const double appBarHeight = 56.0;
  static const double toolbarHeight = 56.0;
  
  // Bottom navigation
  static const double bottomNavHeight = 60.0;
  static const double bottomNavItemSize = 24.0;
  
  // List item dimensions
  static const double listItemHeight = 56.0;
  static const double listItemPadding = md;
  static const double listItemLeadingWidth = 40.0;
  
  // Divider thickness
  static const double dividerThickness = 1.0;
  
  // Elevation levels
  static const double elevationNone = 0.0;
  static const double elevationLow = 1.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;
  
  // Animation durations (in milliseconds)
  static const int animationDurationFast = 150;
  static const int animationDurationMedium = 300;
  static const int animationDurationSlow = 500;
  
  // Screen breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
  
  // Maximum content width for large screens
  static const double maxContentWidth = 1200.0;
  
  // Grid spacing
  static const double gridSpacing = md;
  static const double gridPadding = md;
  
  // Form spacing
  static const double formFieldSpacing = lg;
  static const double formSectionSpacing = xl;
  
  // Dashboard specific
  static const double dashboardCardMinHeight = 120.0;
  static const double dashboardCardSpacing = md;
  static const double dashboardPadding = md;
  
  // Modal and dialog dimensions
  static const double modalPadding = lg;
  static const double modalBorderRadius = radiusLarge;
  static const double dialogMaxWidth = 400.0;
  
  // Scroll physics
  static const double scrollThreshold = 100.0;
  
  // Touch target sizes (accessibility)
  static const double minTouchTarget = 44.0;
  
  // Utility methods
  /// Get responsive padding based on screen width
  static double getResponsivePadding(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return paddingMedium;
    } else if (screenWidth < tabletBreakpoint) {
      return paddingLarge;
    } else {
      return paddingXL;
    }
  }
  
  /// Get responsive margin based on screen width
  static double getResponsiveMargin(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return marginMedium;
    } else if (screenWidth < tabletBreakpoint) {
      return marginLarge;
    } else {
      return marginXL;
    }
  }
  
  /// Get responsive icon size based on screen width
  static double getResponsiveIconSize(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return iconMedium;
    } else if (screenWidth < tabletBreakpoint) {
      return iconLarge;
    } else {
      return iconXL;
    }
  }
  
  /// Get grid column count based on screen width
  static int getGridColumnCount(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return 1;
    } else if (screenWidth < tabletBreakpoint) {
      return 2;
    } else if (screenWidth < desktopBreakpoint) {
      return 3;
    } else {
      return 4;
    }
  }
  
  /// Get responsive button height based on screen width
  static double getResponsiveButtonHeight(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return buttonHeightMedium;
    } else {
      return buttonHeightLarge;
    }
  }
}