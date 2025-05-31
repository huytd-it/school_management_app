import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Dashboard',
        showBackButton: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              AppColors.primaryMint.withOpacity(0.1),
              AppColors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Card
              _buildStudentInfoCard(),
              
              AppSpacing.heightXxl,
              
              // Today's Schedule
              Text('Today\'s Schedule', style: AppTextStyles.h2),
              AppSpacing.heightMd,
              _buildScheduleList(),
              
              AppSpacing.heightXxl,
              
              // Quick Stats
              Row(
                children: [
                  Expanded(child: _buildStatCard('Attendance', '95.5%', Icons.check_circle)),
                  AppSpacing.widthLg,
                  Expanded(child: _buildStatCard('Avg. Grade', 'A-', Icons.star)),
                ],
              ),
              
              AppSpacing.heightXxl,
              
              // Recent Assignments
              Text('Recent Assignments', style: AppTextStyles.h2),
              AppSpacing.heightMd,
              _buildAssignmentsList(),
              
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
          BottomNavItem(icon: Icons.calendar_today_rounded, label: 'Schedule'),
          BottomNavItem(icon: Icons.assignment_rounded, label: 'Assignments'),
          BottomNavItem(icon: Icons.grade_rounded, label: 'Grades'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildStudentInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryMint, AppColors.mintSoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryMint.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
                  'Sarah Johnson',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
                AppSpacing.heightXs,
                Text(
                  'Grade 10-A • Student ID: STU001',
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

  Widget _buildScheduleList() {
    final schedules = [
      {
        'subject': 'Mathematics',
        'time': '9:00 - 10:00 AM',
        'room': 'Room 101',
        'teacher': 'Mr. Anderson',
        'color': AppColors.info,
      },
      {
        'subject': 'Physics',
        'time': '10:15 - 11:15 AM',
        'room': 'Lab 2',
        'teacher': 'Dr. Smith',
        'color': AppColors.warning,
      },
      {
        'subject': 'English',
        'time': '11:30 - 12:30 PM',
        'room': 'Room 205',
        'teacher': 'Ms. Davis',
        'color': AppColors.success,
      },
      {
        'subject': 'Chemistry',
        'time': '2:00 - 3:00 PM',
        'room': 'Lab 1',
        'teacher': 'Dr. Wilson',
        'color': AppColors.primaryMint,
      },
    ];

    return Column(
      children: schedules.map((schedule) {
        return _buildScheduleCard(
          schedule['subject'] as String,
          schedule['time'] as String,
          schedule['room'] as String,
          schedule['teacher'] as String,
          schedule['color'] as Color,
        );
      }).toList(),
    );
  }

  Widget _buildScheduleCard(
    String subject,
    String time,
    String room,
    String teacher,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.softCard,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          AppSpacing.widthMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                      time,
                      style: AppTextStyles.bodySmall,
                    ),
                    AppSpacing.widthMd,
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.darkGray,
                    ),
                    AppSpacing.widthXs,
                    Text(
                      room,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                AppSpacing.heightXs,
                Text(
                  teacher,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.darkGray,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.softCard,
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primaryMint,
            size: 32,
          ),
          AppSpacing.heightMd,
          Text(
            value,
            style: AppTextStyles.h2,
          ),
          AppSpacing.heightXs,
          Text(
            title,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentsList() {
    final assignments = [
      {
        'title': 'Calculus Problem Set',
        'subject': 'Mathematics',
        'dueDate': 'Due Tomorrow',
        'status': 'pending',
      },
      {
        'title': 'Essay on Climate Change',
        'subject': 'English',
        'dueDate': 'Due in 3 days',
        'status': 'in_progress',
      },
      {
        'title': 'Physics Lab Report',
        'subject': 'Physics',
        'dueDate': 'Submitted',
        'status': 'completed',
      },
    ];

    return Column(
      children: assignments.map((assignment) {
        final status = assignment['status'] as String;
        Color statusColor;
        IconData statusIcon;
        
        switch (status) {
          case 'completed':
            statusColor = AppColors.success;
            statusIcon = Icons.check_circle_rounded;
            break;
          case 'in_progress':
            statusColor = AppColors.warning;
            statusIcon = Icons.pending_rounded;
            break;
          default:
            statusColor = AppColors.error;
            statusIcon = Icons.schedule_rounded;
        }

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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              AppSpacing.widthMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment['title'] as String,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      assignment['subject'] as String,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Text(
                assignment['dueDate'] as String,
                style: AppTextStyles.bodySmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}