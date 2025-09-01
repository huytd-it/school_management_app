/// User roles enumeration for the School ERP System
/// Defines all available user roles with their hierarchical levels
enum UserRole {
  superAdmin('super_admin', 'Super Administrator', 1),
  admin('admin', 'Administrator', 2),
  principal('principal', 'Principal', 3),
  vicePrincipal('vice_principal', 'Vice Principal', 4),
  teacher('teacher', 'Teacher', 5),
  student('student', 'Student', 6),
  parent('parent', 'Parent', 7),
  staff('staff', 'Staff', 8),
  librarian('librarian', 'Librarian', 9),
  accountant('accountant', 'Accountant', 10),
  receptionist('receptionist', 'Receptionist', 11),
  security('security', 'Security', 12),
  janitor('janitor', 'Janitor', 13),
  guest('guest', 'Guest', 14);

  const UserRole(this.value, this.displayName, this.level);

  final String value;
  final String displayName;
  final int level; // Lower number = higher privilege

  /// Get role from string value
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.guest,
    );
  }

  /// Check if this role has higher privilege than another role
  bool isHigherThan(UserRole other) {
    return level < other.level;
  }

  /// Check if this role has lower privilege than another role
  bool isLowerThan(UserRole other) {
    return level > other.level;
  }

  /// Check if this role is equal to another role
  bool isEqualTo(UserRole other) {
    return level == other.level;
  }

  /// Get all roles with higher privilege
  List<UserRole> get higherRoles {
    return UserRole.values.where((role) => role.level < level).toList();
  }

  /// Get all roles with lower privilege
  List<UserRole> get lowerRoles {
    return UserRole.values.where((role) => role.level > level).toList();
  }

  /// Check if this is an admin role
  bool get isAdmin => this == UserRole.superAdmin || this == UserRole.admin;

  /// Check if this is a management role
  bool get isManagement => 
      this == UserRole.superAdmin || 
      this == UserRole.admin || 
      this == UserRole.principal || 
      this == UserRole.vicePrincipal;

  /// Check if this is an academic role
  bool get isAcademic => 
      this == UserRole.teacher || 
      this == UserRole.student || 
      this == UserRole.principal || 
      this == UserRole.vicePrincipal;

  /// Check if this is a support role
  bool get isSupport => 
      this == UserRole.staff || 
      this == UserRole.librarian || 
      this == UserRole.accountant || 
      this == UserRole.receptionist || 
      this == UserRole.security || 
      this == UserRole.janitor;

  /// Get role color for UI display
  String get colorHex {
    switch (this) {
      case UserRole.superAdmin:
        return '#FF0000'; // Red
      case UserRole.admin:
        return '#FF6600'; // Orange
      case UserRole.principal:
        return '#9900CC'; // Purple
      case UserRole.vicePrincipal:
        return '#6600CC'; // Dark Purple
      case UserRole.teacher:
        return '#0066CC'; // Blue
      case UserRole.student:
        return '#00CC66'; // Green
      case UserRole.parent:
        return '#CC6600'; // Brown
      case UserRole.staff:
        return '#666666'; // Gray
      case UserRole.librarian:
        return '#CC0066'; // Pink
      case UserRole.accountant:
        return '#CCCC00'; // Yellow
      case UserRole.receptionist:
        return '#00CCCC'; // Cyan
      case UserRole.security:
        return '#333333'; // Dark Gray
      case UserRole.janitor:
        return '#996633'; // Brown
      case UserRole.guest:
        return '#CCCCCC'; // Light Gray
    }
  }

  /// Get role icon for UI display
  String get iconName {
    switch (this) {
      case UserRole.superAdmin:
        return 'admin_panel_settings';
      case UserRole.admin:
        return 'admin_panel_settings';
      case UserRole.principal:
        return 'school';
      case UserRole.vicePrincipal:
        return 'school';
      case UserRole.teacher:
        return 'person';
      case UserRole.student:
        return 'person';
      case UserRole.parent:
        return 'family_restroom';
      case UserRole.staff:
        return 'badge';
      case UserRole.librarian:
        return 'library_books';
      case UserRole.accountant:
        return 'account_balance';
      case UserRole.receptionist:
        return 'support_agent';
      case UserRole.security:
        return 'security';
      case UserRole.janitor:
        return 'cleaning_services';
      case UserRole.guest:
        return 'person_outline';
    }
  }

  /// Get default dashboard route for role
  String get defaultDashboardRoute {
    switch (this) {
      case UserRole.superAdmin:
      case UserRole.admin:
        return '/dashboard/admin';
      case UserRole.principal:
      case UserRole.vicePrincipal:
        return '/dashboard/admin';
      case UserRole.teacher:
        return '/dashboard/teacher';
      case UserRole.student:
        return '/dashboard/student';
      case UserRole.parent:
        return '/dashboard/parent';
      default:
        return '/dashboard/staff';
    }
  }

  /// Get available modules for this role
  List<String> get availableModules {
    switch (this) {
      case UserRole.superAdmin:
        return [
          'user_management',
          'academic_management',
          'finance_management',
          'administration',
          'communication',
          'reports',
          'system_settings',
        ];
        
      case UserRole.admin:
        return [
          'user_management',
          'academic_management',
          'finance_management',
          'administration',
          'communication',
          'reports',
        ];
        
      case UserRole.principal:
      case UserRole.vicePrincipal:
        return [
          'academic_management',
          'finance_management',
          'administration',
          'communication',
          'reports',
        ];
        
      case UserRole.teacher:
        return [
          'academic_management',
          'communication',
          'attendance',
          'grades',
          'assignments',
        ];
        
      case UserRole.student:
        return [
          'academic_view',
          'attendance_view',
          'grades_view',
          'assignments_view',
          'announcements',
        ];
        
      case UserRole.parent:
        return [
          'student_progress',
          'attendance_view',
          'grades_view',
          'communication',
          'fees',
          'announcements',
        ];
        
      case UserRole.accountant:
        return [
          'finance_management',
          'fees',
          'payroll',
          'reports',
        ];
        
      case UserRole.librarian:
        return [
          'library_management',
          'inventory',
          'reports',
        ];
        
      default:
        return [
          'announcements',
          'profile',
        ];
    }
  }

  @override
  String toString() => displayName;
}