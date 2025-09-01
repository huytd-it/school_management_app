import 'package:flutter/material.dart';
import 'modern_bottom_nav.dart';
import 'left_sidebar.dart';

/// Factory class to generate role-specific navigation items
class RoleBasedNavigation {
  // Bottom navigation items for different roles
  static List<BottomNavItem> getBottomNavItems(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.apps_rounded, label: 'Modules'),
          BottomNavItem(icon: Icons.qr_code_scanner_rounded, label: 'QR Code'),
          BottomNavItem(icon: Icons.analytics_rounded, label: 'Reports'),
          BottomNavItem(icon: Icons.settings_rounded, label: 'Settings'),
        ];
      case 'teacher':
        return const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.class_rounded, label: 'Classes'),
          BottomNavItem(icon: Icons.assignment_rounded, label: 'Assignments'),
          BottomNavItem(icon: Icons.people_rounded, label: 'Students'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ];
      case 'student':
        return const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.class_rounded, label: 'Classes'),
          BottomNavItem(icon: Icons.assignment_rounded, label: 'Assignments'),
          BottomNavItem(icon: Icons.calendar_today_rounded, label: 'Schedule'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ];
      case 'parent':
        return const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.child_care_rounded, label: 'Children'),
          BottomNavItem(icon: Icons.payment_rounded, label: 'Payments'),
          BottomNavItem(icon: Icons.message_rounded, label: 'Messages'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ];
      default:
        return const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.apps_rounded, label: 'Modules'),
          BottomNavItem(icon: Icons.message_rounded, label: 'Messages'),
          BottomNavItem(icon: Icons.notifications_rounded, label: 'Alerts'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ];
    }
  }

  // Sidebar items for different roles
  static List<SidebarItem> getSidebarItems(String role) {
    final List<SidebarItem> commonItems = [
      SidebarItem(
        title: 'Dashboard',
        icon: Icons.dashboard_rounded,
        route: '/dashboard',
      ),
      SidebarItem(
        title: 'Messages',
        icon: Icons.message_rounded,
        route: '/messages',
      ),
      SidebarItem(
        title: 'Calendar',
        icon: Icons.calendar_today_rounded,
        route: '/calendar',
      ),
      SidebarItem(
        title: 'Profile',
        icon: Icons.person_rounded,
        route: '/profile',
      ),
    ];

    switch (role.toLowerCase()) {
      case 'admin':
        return [
          ...commonItems,
          SidebarItem(
            title: 'Modules',
            icon: Icons.apps_rounded,
            route: '/modules',
          ),
          SidebarItem(
            title: 'Academic',
            icon: Icons.school_rounded,
            route: '/academic',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'Students',
                icon: Icons.person_rounded,
                route: '/academic/students',
              ),
              SidebarItem(
                title: 'Teachers',
                icon: Icons.person_rounded,
                route: '/academic/teachers',
              ),
              SidebarItem(
                title: 'Classes',
                icon: Icons.class_rounded,
                route: '/academic/classes',
              ),
              SidebarItem(
                title: 'Subjects',
                icon: Icons.book_rounded,
                route: '/academic/subjects',
              ),
            ],
          ),
          SidebarItem(
            title: 'Administrative',
            icon: Icons.business_rounded,
            route: '/administrative',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'Assets',
                icon: Icons.inventory_2_rounded,
                route: '/administrative/assets',
              ),
              SidebarItem(
                title: 'Library',
                icon: Icons.menu_book_rounded,
                route: '/administrative/library',
              ),
              SidebarItem(
                title: 'HR',
                icon: Icons.groups_rounded,
                route: '/administrative/hr',
              ),
            ],
          ),
          SidebarItem(
            title: 'Financial',
            icon: Icons.attach_money_rounded,
            route: '/financial',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'Fees',
                icon: Icons.payments_rounded,
                route: '/financial/fees',
              ),
              SidebarItem(
                title: 'Accounting',
                icon: Icons.account_balance_rounded,
                route: '/financial/accounting',
              ),
            ],
          ),
          SidebarItem(
            title: 'Reports',
            icon: Icons.analytics_rounded,
            route: '/reports',
          ),
          SidebarItem(
            title: 'Settings',
            icon: Icons.settings_rounded,
            route: '/settings',
          ),
        ];
      case 'teacher':
        return [
          ...commonItems,
          SidebarItem(
            title: 'Classes',
            icon: Icons.class_rounded,
            route: '/classes',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'My Classes',
                icon: Icons.groups_rounded,
                route: '/classes/my-classes',
              ),
              SidebarItem(
                title: 'Schedule',
                icon: Icons.schedule_rounded,
                route: '/classes/schedule',
              ),
            ],
          ),
          SidebarItem(
            title: 'Students',
            icon: Icons.school_rounded,
            route: '/students',
          ),
          SidebarItem(
            title: 'Assignments',
            icon: Icons.assignment_rounded,
            route: '/assignments',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'Create New',
                icon: Icons.add_circle_outline_rounded,
                route: '/assignments/create',
              ),
              SidebarItem(
                title: 'Grade',
                icon: Icons.grading_rounded,
                route: '/assignments/grade',
              ),
            ],
          ),
          SidebarItem(
            title: 'Attendance',
            icon: Icons.fact_check_rounded,
            route: '/attendance',
          ),
        ];
      case 'student':
        return [
          ...commonItems,
          SidebarItem(
            title: 'Classes',
            icon: Icons.class_rounded,
            route: '/classes',
          ),
          SidebarItem(
            title: 'Assignments',
            icon: Icons.assignment_rounded,
            route: '/assignments',
          ),
          SidebarItem(
            title: 'Grades',
            icon: Icons.grading_rounded,
            route: '/grades',
          ),
          SidebarItem(
            title: 'Schedule',
            icon: Icons.schedule_rounded,
            route: '/schedule',
          ),
          SidebarItem(
            title: 'Library',
            icon: Icons.menu_book_rounded,
            route: '/library',
          ),
        ];
      case 'parent':
        return [
          ...commonItems,
          SidebarItem(
            title: 'Children',
            icon: Icons.child_care_rounded,
            route: '/children',
            isExpandable: true,
            children: [
              SidebarItem(
                title: 'Profiles',
                icon: Icons.person_rounded,
                route: '/children/profiles',
              ),
              SidebarItem(
                title: 'Academic Progress',
                icon: Icons.trending_up_rounded,
                route: '/children/progress',
              ),
            ],
          ),
          SidebarItem(
            title: 'Attendance',
            icon: Icons.fact_check_rounded,
            route: '/attendance',
          ),
          SidebarItem(
            title: 'Payments',
            icon: Icons.payment_rounded,
            route: '/payments',
          ),
          SidebarItem(
            title: 'Teacher Meetings',
            icon: Icons.people_rounded,
            route: '/meetings',
          ),
        ];
      default:
        return commonItems;
    }
  }
}