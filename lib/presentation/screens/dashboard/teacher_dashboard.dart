import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';
import '../../widgets/dashboard/dashboard_card.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Teacher Dashboard',
        showBackButton: false,
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
              // Welcome Header
              _buildWelcomeHeader(),
              
              AppSpacing.heightXxl,
              
              // Today's Classes
              Text('Today\'s Classes', style: AppTextStyles.h2),
              AppSpacing.heightMd,
              _buildTodayClasses(),
              
              AppSpacing.heightXxl,
              
              // Quick Stats
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildQuickStatCard(
                    'Total Students',
                    '156',
                    Icons.people_rounded,
                    AppColors.info,
                  ),
                  _buildQuickStatCard(
                    'Classes Today',
                    '5',
                    Icons.calendar_today_rounded,
                    AppColors.success,
                  ),
                  _buildQuickStatCard(
                    'Pending Tasks',
                    '12',
                    Icons.task_rounded,
                    AppColors.warning,
                  ),
                  _buildQuickStatCard(
                    'Avg. Attendance',
                    '92%',
                    Icons.check_circle_rounded,
                    AppColors.primaryMint,
                  ),
                ],
              ),
              
              AppSpacing.heightXxl,
              
              // Recent Activities
              Text('Recent Activities', style: AppTextStyles.h2),
              AppSpacing.heightMd,
              _buildRecentActivities(),
              
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: ModernBottomNav(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
          BottomNavItem(icon: Icons.class_rounded, label: 'Classes'),
          BottomNavItem(icon: Icons.assignment_rounded, label: 'Assignments'),
          BottomNavItem(icon: Icons.people_rounded, label: 'Students'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryNavy.withOpacity(0.1),
            AppColors.primaryMint.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.primaryNavy,
              size: 30,
            ),
          ),
          AppSpacing.widthLg,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormatter.getGreeting()}, Dr. Emily Davis',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
                AppSpacing.heightXs,
                Text(
                  'Mathematics Department',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.navyLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayClasses() {
    final classes = [
      {
        'class': 'Grade 10-A',
        'subject': 'Advanced Mathematics',
        'time': '9:00 - 10:00 AM',
        'room': 'Room 101',
        'students': '32',
      },
      {
        'class': 'Grade 11-B',
        'subject': 'Calculus',
        'time': '10:15 - 11:15 AM',
        'room': 'Room 203',
        'students': '28',
      },
      {
        'class': 'Grade 9-C',
        'subject': 'Algebra',
        'time': '2:00 - 3:00 PM',
        'room': 'Room 105',
        'students': '35',
      },
    ];

    return Column(
      children: classes.map((classInfo) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: AppDecorations.softCard,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryMint.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.class_rounded,
                  color: AppColors.primaryMint,
                ),
              ),
              AppSpacing.widthMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classInfo['class'] as String,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      classInfo['subject'] as String,
                      style: AppTextStyles.bodyMedium,
                    ),
                    AppSpacing.heightXs,
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppColors.darkGray,
                        ),
                        AppSpacing.widthXs,
                        Text(
                          classInfo['time'] as String,
                          style: AppTextStyles.caption,
                        ),
                        AppSpacing.widthMd,
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.darkGray,
                        ),
                        AppSpacing.widthXs,
                        Text(
                          classInfo['room'] as String,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    classInfo['students'] as String,
                    style: AppTextStyles.h3,
                  ),
                  Text(
                    'Students',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.softCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: AppTextStyles.h3,
              ),
            ],
          ),
          Text(
            title,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    final activities = [
      {
        'title': 'Assignment Submitted',
        'subtitle': '15 students submitted Math homework',
        'time': '1 hour ago',
        'icon': Icons.assignment_turned_in,
        'color': AppColors.success,
      },
      {
        'title': 'New Message',
        'subtitle': 'Parent inquiry about exam schedule',
        'time': '2 hours ago',
        'icon': Icons.message,
        'color': AppColors.info,
      },
      {
        'title': 'Attendance Marked',
        'subtitle': 'Grade 10-A morning attendance',
        'time': '3 hours ago',
        'icon': Icons.check_circle,
        'color': AppColors.primaryMint,
      },
    ];

    return Column(
      children: activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: AppDecorations.softCard,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: activity['color'] as Color,
                  size: 20,
                ),
              ),
              AppSpacing.widthMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      activity['subtitle'] as String,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                activity['time'] as String,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}