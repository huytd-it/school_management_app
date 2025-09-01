import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'left_sidebar.dart';
import 'modern_bottom_nav.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget body;
  final String title;
  final List<SidebarItem> sidebarItems;
  final List<BottomNavItem> bottomNavItems;
  final String selectedRoute;
  final int selectedBottomNavIndex;
  final Function(String) onSidebarItemSelected;
  final Function(int) onBottomNavItemSelected;
  final String userName;
  final String userRole;
  final String? userImageUrl;
  final VoidCallback onLogout;
  final VoidCallback? onLogin;
  final bool showAppBar;
  final List<Widget>? actions;

  const ResponsiveLayout({
    Key? key,
    required this.body,
    required this.title,
    required this.sidebarItems,
    required this.bottomNavItems,
    required this.selectedRoute,
    required this.selectedBottomNavIndex,
    required this.onSidebarItemSelected,
    required this.onBottomNavItemSelected,
    required this.userName,
    required this.userRole,
    this.userImageUrl,
    required this.onLogout,
    this.onLogin,
    this.showAppBar = true,
    this.actions,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width >= 1200;
    final isMediumScreen = MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(widget.title),
              backgroundColor: AppColors.primaryMint,
              foregroundColor: AppColors.primaryNavy,
              elevation: 0,
              leading: isLargeScreen
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
              actions: [
                if (widget.actions != null) ...widget.actions!,
                if (!isLargeScreen && !isMediumScreen)
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () {
                      // Show user profile or account options
                    },
                  ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login_rounded),
                  label: const Text('Login'),
                  onPressed: () {
                    if (widget.onLogin != null) {
                      widget.onLogin!();
                    } else {
                      _showLoginDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            )
          : null,
      drawer: isLargeScreen
          ? null
          : Drawer(
              child: LeftSidebar(
                items: widget.sidebarItems,
                selectedRoute: widget.selectedRoute,
                onItemSelected: (route) {
                  widget.onSidebarItemSelected(route);
                  Navigator.pop(context);
                },
                userName: widget.userName,
                userRole: widget.userRole,
                userImageUrl: widget.userImageUrl,
                onLogout: widget.onLogout,
              ),
            ),
      body: Row(
        children: [
          if (isLargeScreen)
            LeftSidebar(
              items: widget.sidebarItems,
              selectedRoute: widget.selectedRoute,
              onItemSelected: widget.onSidebarItemSelected,
              userName: widget.userName,
              userRole: widget.userRole,
              userImageUrl: widget.userImageUrl,
              onLogout: widget.onLogout,
            ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE8FCF8), Colors.white],
                ),
              ),
              child: widget.body,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isLargeScreen
          ? null
          : ModernBottomNav(
              selectedIndex: widget.selectedBottomNavIndex,
              onItemSelected: widget.onBottomNavItemSelected,
              items: widget.bottomNavItems,
            ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMint.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: AppColors.primaryNavy,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Login to School Management',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome back! Please enter your credentials to continue.',
                style: TextStyle(
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email or Username',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryMint,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryMint,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle login
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 8),
              // Demo credentials hint
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.info.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: AppColors.info,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Demo Credentials',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'admin@school.com / password\nteacher@school.com / password\nstudent@school.com / password\nparent@school.com / password',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}