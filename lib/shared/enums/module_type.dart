/// Module types enumeration for the School ERP System
/// Defines all available modules with their configurations
enum ModuleType {
  // Core Modules
  dashboard('dashboard', 'Dashboard', 'dashboard', true, 1),
  userManagement('user_management', 'User Management', 'people', false, 2),
  
  // Academic Modules
  studentManagement('student_management', 'Student Management', 'school', true, 3),
  teacherManagement('teacher_management', 'Teacher Management', 'person', true, 4),
  classManagement('class_management', 'Class Management', 'class', true, 5),
  subjectManagement('subject_management', 'Subject Management', 'subject', true, 6),
  curriculum('curriculum', 'Curriculum', 'book', true, 7),
  attendance('attendance', 'Attendance', 'check_circle', true, 8),
  grades('grades', 'Grades & Assessment', 'grade', true, 9),
  assignments('assignments', 'Assignments', 'assignment', true, 10),
  examinations('examinations', 'Examinations', 'quiz', true, 11),
  timetable('timetable', 'Timetable', 'schedule', true, 12),
  
  // Finance Modules
  feeManagement('fee_management', 'Fee Management', 'payment', true, 13),
  payroll('payroll', 'Payroll', 'account_balance_wallet', false, 14),
  budget('budget', 'Budget Management', 'trending_up', false, 15),
  accounting('accounting', 'Accounting', 'account_balance', false, 16),
  
  // Administration Modules
  announcements('announcements', 'Announcements', 'campaign', true, 17),
  events('events', 'Events & Calendar', 'event', true, 18),
  facilities('facilities', 'Facilities Management', 'domain', false, 19),
  inventory('inventory', 'Inventory Management', 'inventory', false, 20),
  library('library', 'Library Management', 'library_books', true, 21),
  transport('transport', 'Transport Management', 'directions_bus', true, 22),
  hostel('hostel', 'Hostel Management', 'hotel', true, 23),
  
  // Communication Modules
  messaging('messaging', 'Messaging', 'message', true, 24),
  notifications('notifications', 'Notifications', 'notifications', true, 25),
  parentPortal('parent_portal', 'Parent Portal', 'family_restroom', true, 26),
  
  // Reports & Analytics
  reports('reports', 'Reports & Analytics', 'assessment', true, 27),
  analytics('analytics', 'Analytics Dashboard', 'analytics', false, 28),
  
  // System Modules
  settings('settings', 'System Settings', 'settings', false, 29),
  security('security', 'Security & Access', 'security', false, 30),
  backup('backup', 'Backup & Restore', 'backup', false, 31),
  logs('logs', 'System Logs', 'history', false, 32),
  
  // Additional Modules
  admission('admission', 'Admission Management', 'how_to_reg', true, 33),
  certificate('certificate', 'Certificate Management', 'workspace_premium', true, 34),
  discipline('discipline', 'Discipline Management', 'gavel', true, 35),
  health('health', 'Health Management', 'local_hospital', true, 36),
  career('career', 'Career Guidance', 'work', true, 37);

  const ModuleType(
    this.value,
    this.displayName,
    this.icon,
    this.isVisible,
    this.order,
  );

  final String value;
  final String displayName;
  final String icon;
  final bool isVisible;
  final int order;

  /// Get module from string value
  static ModuleType? fromString(String value) {
    try {
      return ModuleType.values.firstWhere(
        (module) => module.value == value,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all visible modules sorted by order
  static List<ModuleType> getVisibleModules() {
    return ModuleType.values
        .where((module) => module.isVisible)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get modules by category
  static List<ModuleType> getAcademicModules() {
    return [
      studentManagement,
      teacherManagement,
      classManagement,
      subjectManagement,
      curriculum,
      attendance,
      grades,
      assignments,
      examinations,
      timetable,
    ];
  }

  static List<ModuleType> getFinanceModules() {
    return [
      feeManagement,
      payroll,
      budget,
      accounting,
    ];
  }

  static List<ModuleType> getAdministrationModules() {
    return [
      announcements,
      events,
      facilities,
      inventory,
      library,
      transport,
      hostel,
    ];
  }

  static List<ModuleType> getCommunicationModules() {
    return [
      messaging,
      notifications,
      parentPortal,
    ];
  }

  static List<ModuleType> getSystemModules() {
    return [
      settings,
      security,
      backup,
      logs,
    ];
  }

  /// Get module category
  String get category {
    if (getAcademicModules().contains(this)) return 'Academic';
    if (getFinanceModules().contains(this)) return 'Finance';
    if (getAdministrationModules().contains(this)) return 'Administration';
    if (getCommunicationModules().contains(this)) return 'Communication';
    if (getSystemModules().contains(this)) return 'System';
    if (this == reports || this == analytics) return 'Reports';
    return 'Core';
  }

  /// Get module color based on category
  String get colorHex {
    switch (category) {
      case 'Academic':
        return '#2196F3'; // Blue
      case 'Finance':
        return '#4CAF50'; // Green
      case 'Administration':
        return '#FF9800'; // Orange
      case 'Communication':
        return '#9C27B0'; // Purple
      case 'Reports':
        return '#607D8B'; // Blue Grey
      case 'System':
        return '#795548'; // Brown
      default:
        return '#424242'; // Dark Grey
    }
  }

  /// Get default route for module
  String get defaultRoute {
    switch (this) {
      case dashboard:
        return '/dashboard';
      case userManagement:
        return '/users';
      case studentManagement:
        return '/students';
      case teacherManagement:
        return '/teachers';
      case classManagement:
        return '/classes';
      case subjectManagement:
        return '/subjects';
      case curriculum:
        return '/curriculum';
      case attendance:
        return '/attendance';
      case grades:
        return '/grades';
      case assignments:
        return '/assignments';
      case examinations:
        return '/examinations';
      case timetable:
        return '/timetable';
      case feeManagement:
        return '/fees';
      case payroll:
        return '/payroll';
      case budget:
        return '/budget';
      case accounting:
        return '/accounting';
      case announcements:
        return '/announcements';
      case events:
        return '/events';
      case facilities:
        return '/facilities';
      case inventory:
        return '/inventory';
      case library:
        return '/library';
      case transport:
        return '/transport';
      case hostel:
        return '/hostel';
      case messaging:
        return '/messages';
      case notifications:
        return '/notifications';
      case parentPortal:
        return '/parent-portal';
      case reports:
        return '/reports';
      case analytics:
        return '/analytics';
      case settings:
        return '/settings';
      case security:
        return '/security';
      case backup:
        return '/backup';
      case logs:
        return '/logs';
      case admission:
        return '/admission';
      case certificate:
        return '/certificates';
      case discipline:
        return '/discipline';
      case health:
        return '/health';
      case career:
        return '/career';
    }
  }

  /// Check if module requires special permissions
  bool get requiresSpecialPermission {
    return category == 'System' || 
           this == userManagement || 
           this == payroll || 
           this == budget || 
           this == accounting;
  }

  /// Get module description
  String get description {
    switch (this) {
      case dashboard:
        return 'Main dashboard with overview and quick access';
      case userManagement:
        return 'Manage user accounts, roles, and permissions';
      case studentManagement:
        return 'Manage student information, enrollment, and records';
      case teacherManagement:
        return 'Manage teacher profiles, assignments, and schedules';
      case classManagement:
        return 'Manage classes, sections, and student allocation';
      case subjectManagement:
        return 'Manage subjects, syllabus, and curriculum mapping';
      case curriculum:
        return 'Curriculum planning and academic year management';
      case attendance:
        return 'Track and manage student and staff attendance';
      case grades:
        return 'Grade management, report cards, and assessments';
      case assignments:
        return 'Create, distribute, and track assignments';
      case examinations:
        return 'Examination scheduling, conduct, and results';
      case timetable:
        return 'Create and manage class schedules and timetables';
      case feeManagement:
        return 'Fee structure, collection, and payment tracking';
      case payroll:
        return 'Staff salary management and payroll processing';
      case budget:
        return 'Budget planning and financial management';
      case accounting:
        return 'Complete accounting and financial reporting';
      case announcements:
        return 'School-wide announcements and notifications';
      case events:
        return 'Event planning, scheduling, and management';
      case facilities:
        return 'Facility booking and maintenance management';
      case inventory:
        return 'Inventory tracking and asset management';
      case library:
        return 'Library management and book tracking';
      case transport:
        return 'Transportation and bus route management';
      case hostel:
        return 'Hostel accommodation and facilities management';
      case messaging:
        return 'Internal messaging and communication';
      case notifications:
        return 'System notifications and alerts';
      case parentPortal:
        return 'Parent access to student information';
      case reports:
        return 'Generate various reports and analytics';
      case analytics:
        return 'Advanced analytics and data visualization';
      case settings:
        return 'System configuration and settings';
      case security:
        return 'Security settings and access control';
      case backup:
        return 'Data backup and system restore';
      case logs:
        return 'System logs and audit trails';
      case admission:
        return 'Student admission and enrollment process';
      case certificate:
        return 'Generate and manage certificates';
      case discipline:
        return 'Student discipline tracking and management';
      case health:
        return 'Health records and medical management';
      case career:
        return 'Career guidance and counseling';
    }
  }

  @override
  String toString() => displayName;
}