import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/dashboard/main_dashboard_screen.dart';
import '../../shared/enums/user_role.dart';

/// App routing configuration
/// Manages navigation throughout the application
class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String adminDashboard = '/dashboard/admin';
  static const String teacherDashboard = '/dashboard/teacher';
  static const String studentDashboard = '/dashboard/student';
  static const String parentDashboard = '/dashboard/parent';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Student Management
  static const String students = '/students';
  static const String studentDetail = '/students/detail';
  static const String studentCreate = '/students/create';
  
  // Teacher Management
  static const String teachers = '/teachers';
  static const String teacherDetail = '/teachers/detail';
  static const String teacherCreate = '/teachers/create';
  
  // Class Management
  static const String classes = '/classes';
  static const String classDetail = '/classes/detail';
  static const String classCreate = '/classes/create';
  
  // Subject Management
  static const String subjects = '/subjects';
  static const String subjectDetail = '/subjects/detail';
  static const String subjectCreate = '/subjects/create';
  
  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
        
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
        
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
        
      case dashboard:
      case adminDashboard:
      case teacherDashboard:
      case studentDashboard:
      case parentDashboard:
        return MaterialPageRoute(
          builder: (_) => const MainDashboardScreen(),
          settings: settings,
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
          settings: settings,
        );
    }
  }
  
  /// Get dashboard route based on user role
  static String getDashboardRoute(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
      case UserRole.admin:
      case UserRole.principal:
      case UserRole.vicePrincipal:
        return adminDashboard;
      case UserRole.teacher:
        return teacherDashboard;
      case UserRole.student:
        return studentDashboard;
      case UserRole.parent:
        return parentDashboard;
      default:
        return dashboard;
    }
  }
  
  /// Check if route requires authentication
  static bool requiresAuth(String route) {
    const publicRoutes = [
      splash,
      login,
      register,
      forgotPassword,
      resetPassword,
    ];
    return !publicRoutes.contains(route);
  }
  
  /// Check if user has permission to access route
  static bool hasPermissionForRoute(String route, UserRole userRole, List<String> permissions) {
    // Define route permissions here
    const Map<String, List<UserRole>> routePermissions = {
      adminDashboard: [
        UserRole.superAdmin,
        UserRole.admin,
        UserRole.principal,
        UserRole.vicePrincipal,
      ],
      students: [
        UserRole.superAdmin,
        UserRole.admin,
        UserRole.principal,
        UserRole.vicePrincipal,
        UserRole.teacher,
      ],
      teachers: [
        UserRole.superAdmin,
        UserRole.admin,
        UserRole.principal,
        UserRole.vicePrincipal,
      ],
      // Add more route permissions as needed
    };
    
    final allowedRoles = routePermissions[route];
    if (allowedRoles == null) {
      return true; // No specific restrictions
    }
    
    return allowedRoles.contains(userRole);
  }
}

/// 404 Not Found page
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}