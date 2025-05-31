import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/left_sidebar.dart';
import '../../widgets/common/modern_bottom_nav.dart';
import '../../widgets/common/responsive_layout.dart';
import '../../widgets/common/role_based_navigation.dart';
import '../dashboard/main_dashboard_screen.dart';
import 'modules_screen.dart';
import 'module_detail_screen.dart';

class ModuleDashboard extends StatefulWidget {
  const ModuleDashboard({Key? key}) : super(key: key);

  @override
  State<ModuleDashboard> createState() => _ModuleDashboardState();
}

class _ModuleDashboardState extends State<ModuleDashboard> {
  int _selectedBottomNavIndex = 0; // Default to dashboard tab
  String _selectedRoute = '/dashboard';
  bool _isLoggedIn = true;

  // Get the current user role - in a real app, this would come from authentication
  String get _userRole => 'admin';

  List<SidebarItem> _getSidebarItems() {
    return RoleBasedNavigation.getSidebarItems(_userRole);
  }

  List<BottomNavItem> _getBottomNavItems() {
    return RoleBasedNavigation.getBottomNavItems(_userRole);
  }

  Widget _getScreenForRoute(String route) {
    // Map routes to widgets/screens
    switch (route) {
      case '/dashboard':
        return const MainDashboardScreen();
      case '/modules':
        return const ModulesScreen();
      case '/academic':
        return _buildPlaceholderScreen('Academic Management', Icons.school_rounded);
      case '/academic/students':
        return _buildPlaceholderScreen('Student Management', Icons.person_rounded);
      case '/academic/teachers':
        return _buildPlaceholderScreen('Teacher Management', Icons.person_rounded);
      case '/academic/classes':
        return _buildPlaceholderScreen('Class Management', Icons.class_rounded);
      case '/administrative':
        return _buildPlaceholderScreen('Administrative', Icons.business_rounded);
      case '/administrative/assets':
        return _buildPlaceholderScreen('Asset Management', Icons.inventory_2_rounded);
      case '/administrative/library':
        return _buildPlaceholderScreen('Library Management', Icons.menu_book_rounded);
      case '/financial':
        return _buildPlaceholderScreen('Financial Management', Icons.attach_money_rounded);
      case '/reports':
        return _buildPlaceholderScreen('Reports & Analytics', Icons.analytics_rounded);
      case '/settings':
        return _buildPlaceholderScreen('Settings', Icons.settings_rounded);
      case '/messages':
        return _buildPlaceholderScreen('Messages', Icons.message_rounded);
      case '/profile':
        return _buildPlaceholderScreen('Profile', Icons.person_rounded);
      case '/calendar':
        return _buildPlaceholderScreen('Calendar', Icons.calendar_today_rounded);
      default:
        // If route matches a module, show module detail
        if (route.startsWith('/modules/')) {
          final moduleId = route.split('/').last;
          return ModuleDetailScreen(moduleId: moduleId);
        }
        return const MainDashboardScreen();
    }
  }

  Widget _buildPlaceholderScreen(String title, IconData icon) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryMint.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'This screen is under development',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.darkGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedRoute = '/dashboard';
                  _selectedBottomNavIndex = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMint,
                foregroundColor: AppColors.primaryNavy,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreenForBottomNavIndex(int index) {
    // Map bottom nav index to route
    final navItems = _getBottomNavItems();
    if (index < navItems.length) {
      final label = navItems[index].label.toLowerCase();
      switch (label) {
        case 'dashboard':
          return _getScreenForRoute('/dashboard');
        case 'modules':
          return _getScreenForRoute('/modules');
        case 'users':
          return _getScreenForRoute('/users');
        case 'reports':
          return _getScreenForRoute('/reports');
        case 'settings':
          return _getScreenForRoute('/settings');
        case 'messages':
          return _getScreenForRoute('/messages');
        case 'profile':
          return _getScreenForRoute('/profile');
        case 'academic':
          return _getScreenForRoute('/academic');
        default:
          return const MainDashboardScreen();
      }
    }
    return const MainDashboardScreen();
  }

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
      _selectedRoute = '/dashboard';
      _selectedBottomNavIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      // Show login dialog/screen
      return ResponsiveLayout(
        title: 'School Management',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primaryMint.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 64,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to School Management',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Please login to continue',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        sidebarItems: [],
        bottomNavItems: [],
        selectedRoute: '',
        selectedBottomNavIndex: 0,
        onSidebarItemSelected: (_) {},
        onBottomNavItemSelected: (_) {},
        userName: '',
        userRole: '',
        onLogout: () {},
        onLogin: _handleLogin,
      );
    }

    // Priority: sidebar route > bottom nav
    Widget mainContent;
    if (_selectedRoute.isNotEmpty) {
      mainContent = _getScreenForRoute(_selectedRoute);
    } else {
      mainContent = _getScreenForBottomNavIndex(_selectedBottomNavIndex);
    }

    return ResponsiveLayout(
      title: 'School Management',
      body: mainContent,
      sidebarItems: _getSidebarItems(),
      bottomNavItems: _getBottomNavItems(),
      selectedRoute: _selectedRoute,
      selectedBottomNavIndex: _selectedBottomNavIndex,
      onSidebarItemSelected: (route) {
        setState(() {
          _selectedRoute = route;
          // Update bottom nav index to match if possible
          final navItems = _getBottomNavItems();
          for (int i = 0; i < navItems.length; i++) {
            final label = navItems[i].label.toLowerCase();
            if ((route == '/dashboard' && label == 'dashboard') ||
                (route == '/modules' && label == 'modules') ||
                (route == '/reports' && label == 'reports') ||
                (route == '/settings' && label == 'settings') ||
                (route == '/messages' && label == 'messages') ||
                (route == '/profile' && label == 'profile') ||
                (route == '/academic' && label == 'academic')) {
              _selectedBottomNavIndex = i;
              break;
            }
          }
        });
      },
      onBottomNavItemSelected: (index) {
        setState(() {
          _selectedBottomNavIndex = index;
          final navItems = _getBottomNavItems();
          if (index < navItems.length) {
            final label = navItems[index].label.toLowerCase();
            switch (label) {
              case 'dashboard':
                _selectedRoute = '/dashboard';
                break;
              case 'modules':
                _selectedRoute = '/modules';
                break;
              case 'users':
                _selectedRoute = '/users';
                break;
              case 'reports':
                _selectedRoute = '/reports';
                break;
              case 'settings':
                _selectedRoute = '/settings';
                break;
              case 'messages':
                _selectedRoute = '/messages';
                break;
              case 'profile':
                _selectedRoute = '/profile';
                break;
              case 'academic':
                _selectedRoute = '/academic';
                break;
              default:
                _selectedRoute = '/dashboard';
            }
          }
        });
      },
      userName: 'Admin User',
      userRole: 'School Administrator',
      onLogout: () {
        setState(() {
          _isLoggedIn = false;
          _selectedRoute = '';
          _selectedBottomNavIndex = 0;
        });
      },
      onLogin: _handleLogin,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // Show notifications
          },
        ),
      ],
    );
  }
}