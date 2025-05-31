import 'package:flutter/material.dart';

/// Consistent spacing values throughout the app
class AppSpacing {
  // Base unit
  static const double unit = 4.0;
  
  // Spacing values
  static const double xs = unit * 1;    // 4
  static const double sm = unit * 2;    // 8
  static const double md = unit * 3;    // 12
  static const double lg = unit * 4;    // 16
  static const double xl = unit * 5;    // 20
  static const double xxl = unit * 6;   // 24
  static const double xxxl = unit * 8;  // 32
  static const double huge = unit * 12; // 48
  
  // Padding helpers
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);
  
  // Horizontal padding
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);
  
  // Vertical padding
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVerticalXl = EdgeInsets.symmetric(vertical: xl);
  
  // Screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(xl);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: xl);
  
  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(xl);
  
  // List item padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  
  // Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: xxl,
    vertical: md + 2, // 14
  );
  
  // Icon sizes
  static const double iconSizeSm = 16;
  static const double iconSizeMd = 20;
  static const double iconSizeLg = 24;
  static const double iconSizeXl = 32;
  static const double iconSizeXxl = 48;
  
  // Avatar sizes
  static const double avatarSizeSm = 32;
  static const double avatarSizeMd = 40;
  static const double avatarSizeLg = 48;
  static const double avatarSizeXl = 64;
  static const double avatarSizeXxl = 80;
  
  // Height helpers
  static const SizedBox heightXs = SizedBox(height: xs);
  static const SizedBox heightSm = SizedBox(height: sm);
  static const SizedBox heightMd = SizedBox(height: md);
  static const SizedBox heightLg = SizedBox(height: lg);
  static const SizedBox heightXl = SizedBox(height: xl);
  static const SizedBox heightXxl = SizedBox(height: xxl);
  static const SizedBox heightXxxl = SizedBox(height: xxxl);
  
  // Width helpers
  static const SizedBox widthXs = SizedBox(width: xs);
  static const SizedBox widthSm = SizedBox(width: sm);
  static const SizedBox widthMd = SizedBox(width: md);
  static const SizedBox widthLg = SizedBox(width: lg);
  static const SizedBox widthXl = SizedBox(width: xl);
  static const SizedBox widthXxl = SizedBox(width: xxl);
  static const SizedBox widthXxxl = SizedBox(width: xxxl);
}