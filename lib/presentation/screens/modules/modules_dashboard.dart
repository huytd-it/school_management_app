import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../widgets/common/custom_app_bar.dart';

class ModulesDashboard extends StatefulWidget {
  const ModulesDashboard({super.key});

  @override
  State<ModulesDashboard> createState() => _ModulesDashboardState();
}

class _ModulesDashboardState extends State<ModulesDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'School Modules',
        showBackButton: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mintLight,
              AppColors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('School Management Modules', style: AppTextStyles.h2),
              AppSpacing.heightMd,
              Text(
                'Access all school management features',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
              
              AppSpacing.heightXxl,
              
              // Grid of module cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildModuleCard(
                    'Asset Management',
                    'Track and manage school assets',
                    Icons.inventory_2_rounded,
                    AppColors.info,
                    () => _navigateToModule(context, 'assets'),
                  ),
                  _buildModuleCard(
                    'Library Management',
                    'Manage books and resources',
                    Icons.menu_book_rounded,
                    AppColors.success,
                    () => _navigateToModule(context, 'library'),
                  ),
                  _buildModuleCard(
                    'Recruitment',
                    'Manage hiring process',
                    Icons.people_alt_rounded,
                    AppColors.warning,
                    () => _navigateToModule(context, 'recruitment'),
                  ),
                  _buildModuleCard(
                    'Attendance',
                    'Track staff attendance',
                    Icons.fact_check_rounded,
                    AppColors.primaryMint,
                    () => _navigateToModule(context, 'attendance'),
                  ),
                  _buildModuleCard(
                    'Notifications',
                    'School-wide announcements',
                    Icons.notifications_rounded,
                    AppColors.error,
                    () => _navigateToModule(context, 'notifications'),
                  ),
                  _buildModuleCard(
                    'Transportation',
                    'Manage routes and vehicles',
                    Icons.directions_bus_rounded,
                    AppColors.navyLight,
                    () => _navigateToModule(context, 'transportation'),
                  ),
                  _buildModuleCard(
                    'Canteen',
                    'Manage food services',
                    Icons.restaurant_rounded,
                    Colors.orange,
                    () => _navigateToModule(context, 'canteen'),
                  ),
                  _buildModuleCard(
                    'Events',
                    'Organize school events',
                    Icons.event_rounded,
                    Colors.purple,
                    () => _navigateToModule(context, 'events'),
                  ),
                ],
              ),
              
              AppSpacing.heightXxl,
              
              // Recently accessed modules
              Text('Recently Accessed', style: AppTextStyles.h3),
              AppSpacing.heightMd,
              
              Column(
                children: [
                  _buildRecentModuleItem(
                    'Library Management',
                    'Last accessed: Today, 10:30 AM',
                    Icons.menu_book_rounded,
                    AppColors.success,
                    () => _navigateToModule(context, 'library'),
                  ),
                  AppSpacing.heightMd,
                  _buildRecentModuleItem(
                    'Asset Management',
                    'Last accessed: Yesterday, 2:15 PM',
                    Icons.inventory_2_rounded,
                    AppColors.info,
                    () => _navigateToModule(context, 'assets'),
                  ),
                  AppSpacing.heightMd,
                  _buildRecentModuleItem(
                    'Attendance',
                    'Last accessed: Yesterday, 9:00 AM',
                    Icons.fact_check_rounded,
                    AppColors.primaryMint,
                    () => _navigateToModule(context, 'attendance'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            AppSpacing.heightMd,
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.heightXs,
            Text(
              description,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.darkGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentModuleItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            AppSpacing.widthMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.darkGray,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToModule(BuildContext context, String moduleRoute) {
    switch (moduleRoute) {
      case 'assets':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AssetManagementScreen()),
        );
        break;
      case 'library':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LibraryManagementScreen()),
        );
        break;
      case 'recruitment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecruitmentScreen()),
        );
        break;
      case 'attendance':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendanceScreen()),
        );
        break;
      case 'notifications':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
        break;
      case 'transportation':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransportationScreen()),
        );
        break;
      case 'canteen':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CanteenScreen()),
        );
        break;
      case 'events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsScreen()),
        );
        break;
    }
  }
}

// Placeholder screens for each module
class AssetManagementScreen extends StatelessWidget {
  const AssetManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Asset Management',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Asset Management Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class LibraryManagementScreen extends StatelessWidget {
  const LibraryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Library Management',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Library Management Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class RecruitmentScreen extends StatelessWidget {
  const RecruitmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recruitment',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Recruitment Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Attendance',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Attendance Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Notifications Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class TransportationScreen extends StatelessWidget {
  const TransportationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Transportation',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Transportation Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class CanteenScreen extends StatelessWidget {
  const CanteenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Canteen',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Canteen Screen', style: AppTextStyles.h2),
      ),
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Events',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Events Screen', style: AppTextStyles.h2),
      ),
    );
  }
}