import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';
import '../../widgets/dashboard/dashboard_card.dart';
import '../../widgets/dashboard/action_button.dart';
import '../modules/module_dashboard.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
          
          // Overview Section
          Text('Overview', style: AppTextStyles.h2),
          AppSpacing.heightLg,
          
          // Stats Cards with staggered animation
          AnimationLimiter(
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  DashboardCard(
                    title: 'Total Students',
                    value: '1,234',
                    icon: Icons.school_rounded,
                    accentColor: AppColors.info,
                    trend: '+12%',
                    trendUp: true,
                  ),
                  DashboardCard(
                    title: 'Active Teachers',
                    value: '89',
                    icon: Icons.person_rounded,
                    accentColor: AppColors.success,
                    trend: '+5%',
                    trendUp: true,
                  ),
                  DashboardCard(
                    title: 'This Month Fees',
                    value: '\$45,200',
                    icon: Icons.payments_rounded,
                    accentColor: AppColors.warning,
                    trend: '-3%',
                    trendUp: false,
                  ),
                  DashboardCard(
                    title: 'Attendance Rate',
                    value: '94.2%',
                    icon: Icons.check_circle_rounded,
                    accentColor: AppColors.primaryMint,
                    trend: '+2.1%',
                    trendUp: true,
                  ),
                ],
              ),
            ),
          ),
          
          AppSpacing.heightXxxl,
          
          // Quick Actions
          Text('Quick Actions', style: AppTextStyles.h2),
          AppSpacing.heightLg,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ActionButton(
                title: 'Add Student',
                icon: Icons.person_add_rounded,
                color: AppColors.info,
                onTap: () {
                  // Navigate to add student
                },
              ),
              ActionButton(
                title: 'Create Notice',
                icon: Icons.campaign_rounded,
                color: AppColors.warning,
                onTap: () {
                  // Navigate to create notice
                },
              ),
              ActionButton(
                title: 'View Reports',
                icon: Icons.analytics_rounded,
                color: AppColors.success,
                onTap: () {
                  // Navigate to reports
                },
              ),
              ActionButton(
                title: 'Manage Classes',
                icon: Icons.class_rounded,
                color: AppColors.primaryMint,
                onTap: () {
                  // Navigate to manage classes
                },
              ),
            ],
          ),
          
          AppSpacing.heightXxxl,
          
          // Recent Activities
          Text('Recent Activities', style: AppTextStyles.h2),
          AppSpacing.heightLg,
          _buildRecentActivities(),
          
          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('User Management', style: AppTextStyles.h2),
              ElevatedButton.icon(
                onPressed: () {
                  // Add new user
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMint,
                  foregroundColor: AppColors.primaryNavy,
                ),
              ),
            ],
          ),
          AppSpacing.heightMd,
          
          // User type filter
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildUserTypeChip('All Users', true),
                _buildUserTypeChip('Teachers', false),
                _buildUserTypeChip('Students', false),
                _buildUserTypeChip('Parents', false),
                _buildUserTypeChip('Staff', false),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(12),
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
                    'Search users...',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.mediumGray),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 16,
                        color: AppColors.darkGray,
                      ),
                      AppSpacing.widthXs,
                      Text(
                        'Filters',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Users list
          ...List.generate(5, (index) {
            final userTypes = ['Teacher', 'Student', 'Parent', 'Teacher', 'Staff'];
            final userNames = [
              'Dr. Emily Davis',
              'Sarah Johnson',
              'Mr. Robert Johnson',
              'Ms. Jessica Wilson',
              'Mr. David Brown',
            ];
            final userDetails = [
              'Mathematics Department',
              'Grade 10-A',
              'Parent of Sarah Johnson',
              'English Department',
              'Administrative Staff',
            ];
            final userIcons = [
              Icons.school,
              Icons.person,
              Icons.family_restroom,
              Icons.school,
              Icons.badge,
            ];
            final userColors = [
              AppColors.info,
              AppColors.warning,
              AppColors.success,
              AppColors.info,
              AppColors.primaryMint,
            ];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: AppDecorations.softCard,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: userColors[index].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            userIcons[index],
                            color: userColors[index],
                            size: 24,
                          ),
                        ),
                        AppSpacing.widthMd,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userNames[index],
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
                                      color: userColors[index].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      userTypes[index],
                                      style: AppTextStyles.caption.copyWith(
                                        color: userColors[index],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  AppSpacing.widthMd,
                                  Text(
                                    userDetails[index],
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
                        _buildUserActionButton(
                          'View',
                          Icons.visibility_rounded,
                          AppColors.info,
                        ),
                        _buildUserActionButton(
                          'Edit',
                          Icons.edit_rounded,
                          AppColors.warning,
                        ),
                        _buildUserActionButton(
                          'Message',
                          Icons.message_rounded,
                          AppColors.success,
                        ),
                        _buildUserActionButton(
                          'Delete',
                          Icons.delete_rounded,
                          AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUserTypeChip(String label, bool isSelected) {
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

  Widget _buildUserActionButton(String label, IconData icon, Color color) {
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

  Widget _buildClassesTab() {
    return const ModuleDashboard();
  }

  Widget _buildReportsTab() {
    return Center(
      child: Text('Reports Tab Content', style: AppTextStyles.h2),
    );
  }

  Widget _buildSettingsTab() {
    return Center(
      child: Text('Settings Tab Content', style: AppTextStyles.h2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Admin Dashboard',
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
            _buildUsersTab(),
            _buildClassesTab(),
            _buildReportsTab(),
            _buildSettingsTab(),
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
          BottomNavItem(icon: Icons.people_rounded, label: 'Users'),
          BottomNavItem(icon: Icons.apps_rounded, label: 'Modules'),
          BottomNavItem(icon: Icons.analytics_rounded, label: 'Reports'),
          BottomNavItem(icon: Icons.settings_rounded, label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryMint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.waving_hand,
              color: AppColors.primaryNavy,
              size: 24,
            ),
          ),
          AppSpacing.widthMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormatter.getGreeting()}!',
                  style: AppTextStyles.h2,
                ),
                Text(
                  'John Admin',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/avatar_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    final activities = [
      {
        'title': 'New student enrolled',
        'subtitle': 'Sarah Johnson joined Grade 10-A',
        'time': '2 hours ago',
        'icon': Icons.person_add,
        'color': AppColors.info,
      },
      {
        'title': 'Fee payment received',
        'subtitle': '\$1,200 from Michael Brown',
        'time': '3 hours ago',
        'icon': Icons.payment,
        'color': AppColors.success,
      },
      {
        'title': 'Notice published',
        'subtitle': 'Annual Sports Day announcement',
        'time': '5 hours ago',
        'icon': Icons.campaign,
        'color': AppColors.warning,
      },
      {
        'title': 'Teacher joined',
        'subtitle': 'Dr. Emily Davis - Mathematics',
        'time': 'Yesterday',
        'icon': Icons.person,
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