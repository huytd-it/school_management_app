import 'package:flutter/material.dart';

class BottomNavConstants {
  // Heights
  static const double collapsedHeight = 80.0;
  static const double expandedHeight = 400.0;
  static const double fabSize = 56.0;
  static const double fabIconSize = 28.0;
  
  // Animation durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration fabAnimationDuration = Duration(milliseconds: 200);
  
  // Spacing
  static const double itemSpacing = 8.0;
  static const double moduleGridSpacing = 16.0;
  
  // Border radius
  static const double borderRadius = 24.0;
  static const double moduleBorderRadius = 16.0;
}

class BottomNavItem {
  final IconData icon;
  final String label;
  final String route;
  
  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

// Default navigation items
class DefaultBottomNavItems {
  static const List<BottomNavItem> items = [
    BottomNavItem(
      icon: Icons.dashboard_rounded,
      label: 'Dashboard',
      route: '/dashboard',
    ),
    BottomNavItem(
      icon: Icons.chat_bubble_rounded,
      label: 'Chat',
      route: '/chat',
    ),
    BottomNavItem(
      icon: Icons.settings_rounded,
      label: 'Settings',
      route: '/settings',
    ),
  ];
}
