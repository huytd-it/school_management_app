import 'package:flutter/material.dart';

class ModuleModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final List<String> stats;
  final bool isActive;
  final String route;
  final String category;

  ModuleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.stats,
    this.isActive = true,
    required this.route,
    required this.category,
  });
}

class ModuleCategory {
  static const String academic = 'Academic';
  static const String administrative = 'Administrative';
  static const String financial = 'Financial';
  static const String communication = 'Communication';
  static const String support = 'Support Services';
  static const String system = 'System';
}

// Sample module data
List<ModuleModel> getModules() {
  return [
    // Core Academic Modules
    ModuleModel(
      id: 'student_management',
      title: 'Student Management',
      description: 'Manage student profiles, enrollment, academic records',
      icon: Icons.school_rounded,
      accentColor: const Color(0xFF3B82F6), // blue
      stats: ['1,234 Students', '98% Active'],
      route: '/modules/student',
      category: ModuleCategory.academic,
    ),
    ModuleModel(
      id: 'teacher_management',
      title: 'Teacher Management',
      description: 'Teacher profiles, schedules, performance tracking',
      icon: Icons.person_rounded,
      accentColor: const Color(0xFF10B981), // green
      stats: ['89 Teachers', '42 Active Today'],
      route: '/modules/teacher',
      category: ModuleCategory.academic,
    ),
    ModuleModel(
      id: 'class_subject',
      title: 'Class & Subject Management',
      description: 'Manage classes, subjects, curriculum planning',
      icon: Icons.class_rounded,
      accentColor: const Color(0xFFF59E0B), // orange
      stats: ['45 Classes', '28 Subjects'],
      route: '/modules/class',
      category: ModuleCategory.academic,
    ),
    ModuleModel(
      id: 'assessment',
      title: 'Assessment & Grading',
      description: 'Create exams, grade management, report cards',
      icon: Icons.assignment_rounded,
      accentColor: const Color(0xFF8B5CF6), // purple
      stats: ['156 Exams', '89% Completed'],
      route: '/modules/assessment',
      category: ModuleCategory.academic,
    ),

    // Administrative Modules
    ModuleModel(
      id: 'asset_management',
      title: 'Asset Management',
      description: 'Track school assets, maintenance, depreciation',
      icon: Icons.inventory_2_rounded,
      accentColor: const Color(0xFF06B6D4), // cyan
      stats: ['2,340 Items', '12 Pending'],
      route: '/modules/assets',
      category: ModuleCategory.administrative,
    ),
    ModuleModel(
      id: 'library_management',
      title: 'Library Management',
      description: 'Book catalog, issue/return, digital library',
      icon: Icons.menu_book_rounded,
      accentColor: const Color(0xFFDC2626), // red
      stats: ['15,670 Books', '234 Issued'],
      route: '/modules/library',
      category: ModuleCategory.administrative,
    ),
    ModuleModel(
      id: 'hr_recruitment',
      title: 'HR & Recruitment',
      description: 'Staff recruitment, onboarding, HR processes',
      icon: Icons.groups_rounded,
      accentColor: const Color(0xFF059669), // emerald
      stats: ['5 Open Positions', '23 Applications'],
      route: '/modules/hr',
      category: ModuleCategory.administrative,
    ),
    ModuleModel(
      id: 'attendance',
      title: 'Attendance & Time Tracking',
      description: 'Daily attendance, time tracking, leave management',
      icon: Icons.access_time_rounded,
      accentColor: const Color(0xFF7C3AED), // violet
      stats: ['94.2% Today', 'QR Active'],
      route: '/modules/attendance',
      category: ModuleCategory.administrative,
    ),

    // Financial Modules
    ModuleModel(
      id: 'fee_management',
      title: 'Fee Management',
      description: 'Fee collection, payment tracking, financial reports',
      icon: Icons.payments_rounded,
      accentColor: const Color(0xFFEA580C), // orange-600
      stats: ['\$45,200 Collected', '78 Pending'],
      route: '/modules/fee',
      category: ModuleCategory.financial,
    ),
    ModuleModel(
      id: 'accounting',
      title: 'Accounting & Finance',
      description: 'Financial management, budgeting, expense tracking',
      icon: Icons.account_balance_rounded,
      accentColor: const Color(0xFFBE185D), // pink
      stats: ['\$127K Revenue', '5% Growth'],
      route: '/modules/accounting',
      category: ModuleCategory.financial,
    ),

    // Communication Modules
    ModuleModel(
      id: 'notifications',
      title: 'Notifications & Announcements',
      description: 'School announcements, alerts, communication hub',
      icon: Icons.campaign_rounded,
      accentColor: const Color(0xFFDC2626), // red-600
      stats: ['12 Active', '1,890 Sent Today'],
      route: '/modules/notifications',
      category: ModuleCategory.communication,
    ),
    ModuleModel(
      id: 'events',
      title: 'Events & Calendar',
      description: 'School events, calendar management, scheduling',
      icon: Icons.event_rounded,
      accentColor: const Color(0xFF7C2D12), // orange-900
      stats: ['8 This Month', '2 Today'],
      route: '/modules/events',
      category: ModuleCategory.communication,
    ),
    ModuleModel(
      id: 'parent_communication',
      title: 'Parent Communication',
      description: 'Parent portal, messaging, progress sharing',
      icon: Icons.family_restroom_rounded,
      accentColor: const Color(0xFF1565C0), // blue-700
      stats: ['567 Parents', '89% Active'],
      route: '/modules/parent',
      category: ModuleCategory.communication,
    ),

    // Support Services
    ModuleModel(
      id: 'transport',
      title: 'Transport Management',
      description: 'Bus routes, driver management, GPS tracking',
      icon: Icons.directions_bus_rounded,
      accentColor: const Color(0xFFF97316), // orange-500
      stats: ['12 Routes', '234 Students'],
      route: '/modules/transport',
      category: ModuleCategory.support,
    ),
    ModuleModel(
      id: 'health',
      title: 'Health & Medical',
      description: 'Student health records, medical alerts, checkups',
      icon: Icons.medical_services_rounded,
      accentColor: const Color(0xFFEF4444), // red-500
      stats: ['45 Records', '3 Alerts'],
      route: '/modules/health',
      category: ModuleCategory.support,
    ),
    ModuleModel(
      id: 'canteen',
      title: 'Canteen Management',
      description: 'Menu management, orders, nutrition tracking',
      icon: Icons.restaurant_rounded,
      accentColor: const Color(0xFF84CC16), // lime
      stats: ['234 Orders', '\$1,234 Today'],
      route: '/modules/canteen',
      category: ModuleCategory.support,
    ),

    // System Modules
    ModuleModel(
      id: 'reports',
      title: 'Reports & Analytics',
      description: 'Generate reports, data analytics, insights',
      icon: Icons.analytics_rounded,
      accentColor: const Color(0xFF6366F1), // indigo
      stats: ['25 Reports', 'Updated Daily'],
      route: '/modules/reports',
      category: ModuleCategory.system,
    ),
    ModuleModel(
      id: 'settings',
      title: 'Settings & Configuration',
      description: 'System settings, user management, preferences',
      icon: Icons.settings_rounded,
      accentColor: const Color(0xFF6B7280), // gray
      stats: ['System Healthy', 'Last Update: 2h'],
      route: '/modules/settings',
      category: ModuleCategory.system,
    ),
  ];
}

// Sample recent activity data
class RecentActivity {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  final String moduleId;

  RecentActivity({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    required this.moduleId,
  });
}

List<RecentActivity> getRecentActivities() {
  return [
    RecentActivity(
      title: 'New Student Enrolled',
      description: 'John Smith was enrolled in Class 10A',
      time: '10m ago',
      icon: Icons.school_rounded,
      color: const Color(0xFF3B82F6),
      moduleId: 'student_management',
    ),
    RecentActivity(
      title: 'Fee Payment Received',
      description: 'Sarah Johnson paid \$450 for Term 2',
      time: '1h ago',
      icon: Icons.payments_rounded,
      color: const Color(0xFFEA580C),
      moduleId: 'fee_management',
    ),
    RecentActivity(
      title: 'New Announcement',
      description: 'Annual Sports Day scheduled for next month',
      time: '2h ago',
      icon: Icons.campaign_rounded,
      color: const Color(0xFFDC2626),
      moduleId: 'notifications',
    ),
    RecentActivity(
      title: 'Teacher Absence',
      description: 'Mr. Robert applied for leave on Friday',
      time: '3h ago',
      icon: Icons.person_rounded,
      color: const Color(0xFF10B981),
      moduleId: 'teacher_management',
    ),
    RecentActivity(
      title: 'New Books Added',
      description: '25 new science books added to library',
      time: '5h ago',
      icon: Icons.menu_book_rounded,
      color: const Color(0xFFDC2626),
      moduleId: 'library_management',
    ),
  ];
}

// Sample quick stats data
class QuickStat {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  QuickStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

List<QuickStat> getQuickStats() {
  return [
    QuickStat(
      title: 'Total Students',
      value: '1,234',
      icon: Icons.school_rounded,
      color: const Color(0xFF3B82F6),
    ),
    QuickStat(
      title: 'Total Teachers',
      value: '89',
      icon: Icons.person_rounded,
      color: const Color(0xFF10B981),
    ),
    QuickStat(
      title: 'Today\'s Attendance',
      value: '94.2%',
      icon: Icons.fact_check_rounded,
      color: const Color(0xFF7C3AED),
    ),
    QuickStat(
      title: 'Revenue This Month',
      value: '\$45.2K',
      icon: Icons.account_balance_wallet_rounded,
      color: const Color(0xFFEA580C),
    ),
  ];
}