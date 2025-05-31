import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildScheduleTab() {
    final weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Schedule', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          // Day selector
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final isToday = index == 0; // Assume first day is today for demo
                
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isToday ? AppColors.primaryMint : AppColors.lightGray,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      weekDays[index],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isToday ? AppColors.primaryNavy : AppColors.darkGray,
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          AppSpacing.heightXxl,
          
          // Schedule for selected day
          ...['8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM'].map((time) {
            // For demo, only add classes to some time slots
            Widget? classWidget;
            
            if (time == '9:00 AM') {
              classWidget = _buildScheduleCard(
                'Mathematics',
                '9:00 - 10:00 AM',
                'Room 101',
                'Mr. Anderson',
                AppColors.info,
              );
            } else if (time == '10:00 AM') {
              classWidget = _buildScheduleCard(
                'Physics',
                '10:15 - 11:15 AM',
                'Lab 2',
                'Dr. Smith',
                AppColors.warning,
              );
            } else if (time == '11:00 AM') {
              classWidget = _buildScheduleCard(
                'English',
                '11:30 - 12:30 PM',
                'Room 205',
                'Ms. Davis',
                AppColors.success,
              );
            } else if (time == '2:00 PM') {
              classWidget = _buildScheduleCard(
                'Chemistry',
                '2:00 - 3:00 PM',
                'Lab 1',
                'Dr. Wilson',
                AppColors.primaryMint,
              );
            }
            
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        time,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: classWidget ?? Container(
                        height: 1,
                        color: AppColors.mediumGray,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ],
                ),
                if (classWidget == null) AppSpacing.heightMd,
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAssignmentsTab() {
    final assignments = [
      {
        'title': 'Calculus Problem Set',
        'subject': 'Mathematics',
        'dueDate': 'Tomorrow, 11:59 PM',
        'description': 'Complete problems 1-20 from Chapter 5',
        'status': 'pending',
      },
      {
        'title': 'Essay on Climate Change',
        'subject': 'English',
        'dueDate': 'March 15, 11:59 PM',
        'description': 'Write a 1000-word essay on the effects of climate change',
        'status': 'in_progress',
      },
      {
        'title': 'Physics Lab Report',
        'subject': 'Physics',
        'dueDate': 'Submitted on March 5',
        'description': 'Write a report on the pendulum experiment',
        'status': 'completed',
      },
      {
        'title': 'History Research Paper',
        'subject': 'History',
        'dueDate': 'March 20, 11:59 PM',
        'description': 'Research paper on World War II',
        'status': 'pending',
      },
      {
        'title': 'Chemistry Worksheet',
        'subject': 'Chemistry',
        'dueDate': 'March 18, 11:59 PM',
        'description': 'Complete the worksheet on chemical reactions',
        'status': 'pending',
      },
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assignments', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          // Filter tabs
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryMint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'All',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Pending',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Completed',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Assignments list
          ...assignments.map((assignment) {
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
              margin: const EdgeInsets.only(bottom: 16),
              decoration: AppDecorations.softCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                assignment['subject'] as String,
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      assignment['description'] as String,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  Divider(
                    color: AppColors.mediumGray,
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: statusColor,
                            ),
                            AppSpacing.widthXs,
                            Text(
                              assignment['dueDate'] as String,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (status != 'completed')
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryMint,
                              foregroundColor: AppColors.primaryNavy,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: Text('Submit'),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGradesTab() {
    final subjects = [
      {
        'name': 'Mathematics',
        'grade': 'A',
        'percentage': 95.5,
        'color': AppColors.info,
      },
      {
        'name': 'Physics',
        'grade': 'A-',
        'percentage': 91.2,
        'color': AppColors.warning,
      },
      {
        'name': 'English',
        'grade': 'B+',
        'percentage': 88.7,
        'color': AppColors.success,
      },
      {
        'name': 'Chemistry',
        'grade': 'A',
        'percentage': 94.3,
        'color': AppColors.primaryMint,
      },
      {
        'name': 'History',
        'grade': 'B',
        'percentage': 85.1,
        'color': AppColors.error,
      },
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Grades', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Overall GPA',
                      style: AppTextStyles.bodyLarge,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '3.8/4.0',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.heightLg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildGradeCircle('A', 3),
                    _buildGradeCircle('B', 2),
                    _buildGradeCircle('C', 0),
                    _buildGradeCircle('D', 0),
                    _buildGradeCircle('F', 0),
                  ],
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Text('Subject Grades', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          ...subjects.map((subject) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: AppDecorations.softCard,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subject['name'] as String,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: (subject['color'] as Color).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                subject['grade'] as String,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: subject['color'] as Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          AppSpacing.widthMd,
                          Text(
                            '${subject['percentage']}%',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSpacing.heightMd,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (subject['percentage'] as double) / 100,
                      backgroundColor: (subject['color'] as Color).withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(subject['color'] as Color),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGradeCircle(String grade, int count) {
    final bool hasGrades = count > 0;
    
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasGrades ? AppColors.primaryMint : AppColors.lightGray,
          ),
          child: Center(
            child: Text(
              grade,
              style: AppTextStyles.bodyLarge.copyWith(
                color: hasGrades ? AppColors.primaryNavy : AppColors.darkGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        AppSpacing.heightSm,
        Text(
          count.toString(),
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Classes',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryMint,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryNavy.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primaryNavy,
                    size: 50,
                  ),
                ),
                AppSpacing.heightMd,
                Text(
                  'Sarah Johnson',
                  style: AppTextStyles.h2,
                ),
                Text(
                  'Grade 10-A • Student ID: STU001',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Text('Personal Information', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                _buildProfileInfoRow('Date of Birth', 'April 15, 2008'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Email', 'sarah.johnson@school.edu'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Phone', '(555) 123-4567'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Address', '123 Main St, Anytown, USA'),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Text('Academic Information', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                _buildProfileInfoRow('Class', 'Grade 10-A'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Homeroom Teacher', 'Ms. Davis'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Enrollment Date', 'September 1, 2022'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Current GPA', '3.8/4.0'),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle logout
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error.withOpacity(0.1),
                foregroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          
          AppSpacing.heightXxl,
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkGray,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

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
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildDashboardTab(),
            _buildScheduleTab(),
            _buildAssignmentsTab(),
            _buildGradesTab(),
            _buildProfileTab(),
          ],
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