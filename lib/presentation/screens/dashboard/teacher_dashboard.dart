import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildClassesTab() {
    final classes = [
      {
        'class': 'Grade 10-A',
        'subject': 'Advanced Mathematics',
        'students': 32,
        'schedule': 'Mon, Wed, Fri • 9:00 - 10:00 AM',
        'room': 'Room 101',
      },
      {
        'class': 'Grade 11-B',
        'subject': 'Calculus',
        'students': 28,
        'schedule': 'Mon, Wed, Fri • 10:15 - 11:15 AM',
        'room': 'Room 203',
      },
      {
        'class': 'Grade 9-C',
        'subject': 'Algebra',
        'students': 35,
        'schedule': 'Tue, Thu • 2:00 - 3:00 PM',
        'room': 'Room 105',
      },
      {
        'class': 'Grade 10-B',
        'subject': 'Advanced Mathematics',
        'students': 30,
        'schedule': 'Tue, Thu • 9:00 - 10:00 AM',
        'room': 'Room 102',
      },
      {
        'class': 'Grade 12-A',
        'subject': 'Advanced Calculus',
        'students': 25,
        'schedule': 'Mon, Wed • 1:00 - 2:30 PM',
        'room': 'Room 205',
      },
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Classes', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          ...classes.map((classInfo) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: AppDecorations.softCard,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
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
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${classInfo['students']} Students',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.info,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.mediumGray,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 16,
                                color: AppColors.darkGray,
                              ),
                              AppSpacing.widthXs,
                              Expanded(
                                child: Text(
                                  classInfo['schedule'] as String,
                                  style: AppTextStyles.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.darkGray,
                            ),
                            AppSpacing.widthXs,
                            Text(
                              classInfo['room'] as String,
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.mediumGray,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildClassActionButton(
                          'Attendance',
                          Icons.how_to_reg_rounded,
                          AppColors.success,
                        ),
                        _buildClassActionButton(
                          'Assignments',
                          Icons.assignment_rounded,
                          AppColors.warning,
                        ),
                        _buildClassActionButton(
                          'Grades',
                          Icons.grade_rounded,
                          AppColors.info,
                        ),
                        _buildClassActionButton(
                          'Details',
                          Icons.info_outline_rounded,
                          AppColors.primaryNavy,
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

  Widget _buildClassActionButton(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Handle action
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            AppSpacing.heightXs,
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentsTab() {
    final assignments = [
      {
        'title': 'Calculus Problem Set',
        'class': 'Grade 11-B',
        'dueDate': 'Tomorrow, 11:59 PM',
        'status': 'active',
        'submissions': '15/28',
      },
      {
        'title': 'Algebra Quiz',
        'class': 'Grade 9-C',
        'dueDate': 'March 15, 11:59 PM',
        'status': 'active',
        'submissions': '20/35',
      },
      {
        'title': 'Mathematics Test',
        'class': 'Grade 10-A',
        'dueDate': 'Ended on March 5',
        'status': 'ended',
        'submissions': '32/32',
      },
      {
        'title': 'Advanced Calculus Project',
        'class': 'Grade 12-A',
        'dueDate': 'March 20, 11:59 PM',
        'status': 'active',
        'submissions': '10/25',
      },
      {
        'title': 'Mathematics Homework',
        'class': 'Grade 10-B',
        'dueDate': 'Ended on March 1',
        'status': 'ended',
        'submissions': '28/30',
      },
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Assignments', style: AppTextStyles.h2),
              ElevatedButton.icon(
                onPressed: () {
                  // Create new assignment
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMint,
                  foregroundColor: AppColors.primaryNavy,
                ),
              ),
            ],
          ),
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
                      'Active',
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
                      'Ended',
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
            final bool isActive = assignment['status'] == 'active';
            
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: AppDecorations.softCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (isActive ? AppColors.warning : AppColors.success).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isActive ? Icons.assignment_rounded : Icons.assignment_turned_in_rounded,
                          color: isActive ? AppColors.warning : AppColors.success,
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
                              assignment['class'] as String,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (isActive ? AppColors.warning : AppColors.success).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isActive ? 'Active' : 'Ended',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isActive ? AppColors.warning : AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.heightMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: AppColors.darkGray,
                          ),
                          AppSpacing.widthXs,
                          Text(
                            assignment['dueDate'] as String,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people_rounded,
                            size: 16,
                            color: AppColors.darkGray,
                          ),
                          AppSpacing.widthXs,
                          Text(
                            'Submissions: ${assignment['submissions']}',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSpacing.heightMd,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // View submissions
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryNavy,
                            side: const BorderSide(color: AppColors.primaryMint),
                          ),
                          child: const Text('View Submissions'),
                        ),
                      ),
                      AppSpacing.widthMd,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Edit assignment
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryMint,
                            foregroundColor: AppColors.primaryNavy,
                          ),
                          child: Text(isActive ? 'Edit' : 'View Details'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStudentsTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Students', style: AppTextStyles.h2),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people_rounded,
                      size: 16,
                      color: AppColors.info,
                    ),
                    AppSpacing.widthXs,
                    Text(
                      'Total: 156',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.info,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.heightMd,
          
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.darkGray,
                  size: 20,
                ),
                AppSpacing.widthMd,
                Expanded(
                  child: Text(
                    'Search students...',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Class filter
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildClassFilterChip('All Classes', true),
                _buildClassFilterChip('Grade 10-A', false),
                _buildClassFilterChip('Grade 11-B', false),
                _buildClassFilterChip('Grade 9-C', false),
                _buildClassFilterChip('Grade 10-B', false),
                _buildClassFilterChip('Grade 12-A', false),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Students list
          ...List.generate(10, (index) {
            final studentNames = [
              'John Smith',
              'Emily Johnson',
              'Michael Brown',
              'Sarah Davis',
              'David Wilson',
              'Jessica Taylor',
              'James Anderson',
              'Jennifer Thomas',
              'Robert Jackson',
              'Elizabeth White',
            ];
            
            final classes = [
              'Grade 10-A',
              'Grade 11-B',
              'Grade 9-C',
              'Grade 10-A',
              'Grade 12-A',
              'Grade 10-B',
              'Grade 11-B',
              'Grade 9-C',
              'Grade 10-A',
              'Grade 12-A',
            ];
            
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
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        studentNames[index].substring(0, 1),
                        style: AppTextStyles.h3,
                      ),
                    ),
                  ),
                  AppSpacing.widthMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentNames[index],
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryMint.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                classes[index],
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primaryNavy,
                                ),
                              ),
                            ),
                            AppSpacing.widthMd,
                            Text(
                              'ID: STU${1000 + index}',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.darkGray,
                    ),
                    onPressed: () {
                      // Show options
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildClassFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryMint : AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: isSelected ? AppColors.primaryNavy : AppColors.darkGray,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
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
                  'Dr. Emily Davis',
                  style: AppTextStyles.h2,
                ),
                Text(
                  'Mathematics Department • Teacher ID: TCH001',
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
                _buildProfileInfoRow('Email', 'emily.davis@school.edu'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Phone', '(555) 987-6543'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Address', '456 Oak St, Anytown, USA'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Date of Birth', 'June 12, 1985'),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Text('Professional Information', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                _buildProfileInfoRow('Department', 'Mathematics'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Qualification', 'Ph.D. in Mathematics'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Experience', '8 Years'),
                Divider(height: 24, color: AppColors.mediumGray),
                _buildProfileInfoRow('Joining Date', 'August 15, 2016'),
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
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildDashboardTab(),
            _buildClassesTab(),
            _buildAssignmentsTab(),
            _buildStudentsTab(),
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