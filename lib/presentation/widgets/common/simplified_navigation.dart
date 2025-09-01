import 'package:flutter/material.dart';
import 'modern_bottom_nav.dart';

/// Simplified navigation structure that removes complex role-based navigation
/// and provides a unified experience for all users
class SimplifiedNavigation {
  
  /// Get simplified bottom navigation items for all roles
  static List<BottomNavItem> getBottomNavItems() {
    return const [
      BottomNavItem(
        icon: Icons.dashboard_rounded, 
        label: 'Dashboard',
      ),
      BottomNavItem(
        icon: Icons.apps_rounded, 
        label: 'Modules',
      ),
      BottomNavItem(
        icon: Icons.qr_code_scanner_rounded, 
        label: 'QR Scanner',
      ),
      BottomNavItem(
        icon: Icons.person_rounded, 
        label: 'Profile',
      ),
    ];
  }
  
  /// Get route for bottom navigation index
  static String getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/dashboard';
      case 1:
        return '/modules';
      case 2:
        return '/qr-scanner';
      case 3:
        return '/profile';
      default:
        return '/dashboard';
    }
  }
  
  /// Get index for route
  static int getIndexForRoute(String route) {
    switch (route) {
      case '/dashboard':
        return 0;
      case '/modules':
        return 1;
      case '/qr-scanner':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }
  
  /// Get simplified navigation actions for app bar
  static List<Widget> getAppBarActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search_rounded),
        onPressed: () {
          // Handle search
        },
        tooltip: 'Search',
      ),
      IconButton(
        icon: const Icon(Icons.notifications_outlined),
        onPressed: () {
          // Handle notifications
        },
        tooltip: 'Notifications',
      ),
      const SizedBox(width: 8),
    ];
  }
  
  /// Get user menu items for profile section
  static List<UserMenuItem> getUserMenuItems() {
    return [
      UserMenuItem(
        icon: Icons.person_outline,
        title: 'My Profile',
        onTap: () {
          // Handle profile
        },
      ),
      UserMenuItem(
        icon: Icons.settings_outlined,
        title: 'Settings',
        onTap: () {
          // Handle settings
        },
      ),
      UserMenuItem(
        icon: Icons.help_outline,
        title: 'Help & Support',
        onTap: () {
          // Handle help
        },
      ),
      UserMenuItem(
        icon: Icons.logout_rounded,
        title: 'Logout',
        onTap: () {
          // Handle logout - will be implemented in the calling widget
        },
        isDestructive: true,
      ),
    ];
  }
}

/// User menu item model
class UserMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  
  const UserMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });
}