import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../features/auth/presentation/bloc/auth_state.dart';
import '../../widgets/common/simplified_navigation.dart';
import '../../widgets/common/simplified_app_layout.dart';
import '../auth/login_screen.dart';
import '../dashboard/main_dashboard_screen.dart';
import 'modules_screen.dart';
import 'module_detail_screen.dart';
import '../qr_scanner_screen.dart';

class ModuleDashboard extends StatefulWidget {
  const ModuleDashboard({Key? key}) : super(key: key);

  @override
  State<ModuleDashboard> createState() => _ModuleDashboardState();
}

class _ModuleDashboardState extends State<ModuleDashboard> {
  int _selectedIndex = 0;
  String _currentRoute = '/dashboard';

  String get _userName {
    final authBloc = context.read<AuthBloc>();
    return authBloc.currentUser?.name ?? 'User';
  }



  Widget _getScreenForRoute(String route) {
    switch (route) {
      case '/dashboard':
        return const MainDashboardScreen();
      case '/modules':
        return const ModulesScreen();
      case '/qr-scanner':
        return const QRScannerScreen();
      case '/profile':
        return _buildProfileScreen();
      default:
        return const MainDashboardScreen();
    }
  }

  Widget _buildProfileScreen() {
    return const Center(
      child: Text(
        'Profile Screen\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.darkGray,
        ),
      ),
    );
  }

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _currentRoute = SimplifiedNavigation.getRouteForIndex(index);
    });
  }

  String _getPageTitle() {
    switch (_currentRoute) {
      case '/dashboard':
        return 'Dashboard';
      case '/modules':
        return 'Modules';
      case '/qr-scanner':
        return 'QR Scanner';
      case '/profile':
        return 'Profile';
      default:
        return 'School Management';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate to login screen when user logs out
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUnauthenticated || state is AuthInitial) {
            return const LoginScreen();
          }

          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryMint),
                ),
              ),
            );
          }

          return SimplifiedAppLayout(
            title: _getPageTitle(),
            selectedIndex: _selectedIndex,
            onNavigationChanged: _onNavigationChanged,
            body: _getScreenForRoute(_currentRoute),
          );
        },
      ),
    );
  }
}