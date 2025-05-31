import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_formatter.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/modern_bottom_nav.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int _selectedIndex = 0;
  int _selectedChildIndex = 0;

  final List<Map<String, String>> children = [
    {
      'name': 'Sarah Johnson',
      'class': 'Grade 10-A',
      'id': 'STU001',
    },
    {
      'name': 'Michael Johnson',
      'class': 'Grade 7-B',
      'id': 'STU002',
    },
  ];

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          _buildWelcomeHeader(),
          
          AppSpacing.heightXxl,
          
          // Child Selector
          _buildChildSelector(),
          
          AppSpacing.heightXxl,
          
          // Child Overview
          _buildChildOverview(),
          
          AppSpacing.heightXxl,
          
          // Quick Actions
          Text('Quick Actions', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          _buildQuickActions(),
          
          AppSpacing.heightXxl,
          
          // Recent Updates
          Text('Recent Updates', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          _buildRecentUpdates(),
          
          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildChildrenTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Children', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          ...children.map((child) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryMint.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.child_care_rounded,
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
                        child['name']!,
                        style: AppTextStyles.h3,
                      ),
                      AppSpacing.heightXs,
                      Text(
                        '${child['class']}  •  ID: ${child['id']}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkGray,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.darkGray,
                  ),
                  onPressed: () {
                    // Navigate to child details
                  },
                ),
              ],
            ),
          )).toList(),
          
          AppSpacing.heightXxl,
          
          Text('Academic Performance', style: AppTextStyles.h2),
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
                      'Sarah Johnson',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
                        'Grade: A-',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.heightLg,
                _buildSubjectProgressBar('Mathematics', 0.92, AppColors.info),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('Science', 0.85, AppColors.success),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('English', 0.78, AppColors.warning),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('History', 0.88, AppColors.primaryMint),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Michael Johnson',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Grade: B+',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.heightLg,
                _buildSubjectProgressBar('Mathematics', 0.75, AppColors.info),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('Science', 0.82, AppColors.success),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('English', 0.70, AppColors.warning),
                AppSpacing.heightMd,
                _buildSubjectProgressBar('History', 0.79, AppColors.primaryMint),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectProgressBar(String subject, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: AppTextStyles.bodyMedium,
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        AppSpacing.heightXs,
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildFeesTab() {
    final feeItems = [
      {
        'term': 'Term 1 Tuition',
        'amount': '\$2,500',
        'dueDate': '15 Sep 2023',
        'status': 'Paid',
      },
      {
        'term': 'Term 2 Tuition',
        'amount': '\$2,500',
        'dueDate': '15 Jan 2024',
        'status': 'Pending',
      },
      {
        'term': 'Annual Library Fee',
        'amount': '\$150',
        'dueDate': '30 Sep 2023',
        'status': 'Paid',
      },
      {
        'term': 'Sports Activities',
        'amount': '\$300',
        'dueDate': '15 Feb 2024',
        'status': 'Pending',
      },
      {
        'term': 'School Trip',
        'amount': '\$450',
        'dueDate': '10 Mar 2024',
        'status': 'Pending',
      },
    ];

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fee Summary', style: AppTextStyles.h2),
          AppSpacing.heightMd,
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.softCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Fees',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          '\$5,900',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Paid',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          '\$2,650',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSpacing.heightLg,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    backgroundColor: AppColors.lightGray,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
                    minHeight: 10,
                  ),
                ),
                AppSpacing.heightMd,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining: \$3,250',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                    Text(
                      '45% Paid',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          AppSpacing.heightXxl,
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fee Details', style: AppTextStyles.h2),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle payment
                },
                icon: const Icon(Icons.payment_rounded, size: 18),
                label: const Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
          AppSpacing.heightMd,
          
          ...feeItems.map((fee) {
            final bool isPaid = fee['status'] == 'Paid';
            
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
                      color: (isPaid ? AppColors.success : AppColors.warning).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isPaid ? Icons.check_circle_rounded : Icons.pending_rounded,
                      color: isPaid ? AppColors.success : AppColors.warning,
                      size: 20,
                    ),
                  ),
                  AppSpacing.widthMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fee['term']!,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Due: ${fee['dueDate']}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        fee['amount']!,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (isPaid ? AppColors.success : AppColors.warning).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          fee['status']!,
                          style: AppTextStyles.caption.copyWith(
                            color: isPaid ? AppColors.success : AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildMessagesTab() {
    return Center(
      child: Text('Messages Tab Content', style: AppTextStyles.h2),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text('Profile Tab Content', style: AppTextStyles.h2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Parent Dashboard',
        showBackButton: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryMint.withOpacity(0.05),
              AppColors.white,
            ],
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildDashboardTab(),
            _buildChildrenTab(),
            _buildFeesTab(),
            _buildMessagesTab(),
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
          BottomNavItem(icon: Icons.child_care_rounded, label: 'Children'),
          BottomNavItem(icon: Icons.payment_rounded, label: 'Fees'),
          BottomNavItem(icon: Icons.message_rounded, label: 'Messages'),
          BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Row(
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
                '${DateFormatter.getGreeting()}, Mr. Johnson',
                style: AppTextStyles.h3,
              ),
              Text(
                'Parent of ${children.length} students',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChildSelector() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];
          final isSelected = index == _selectedChildIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedChildIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(16),
              width: 160,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryMint : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryMint
                      : AppColors.mediumGray,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primaryMint.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.child_care_rounded,
                    color: isSelected
                        ? AppColors.primaryNavy
                        : AppColors.darkGray,
                    size: 24,
                  ),
                  AppSpacing.heightSm,
                  Text(
                    child['name']!,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryNavy
                          : AppColors.charcoal,
                    ),
                  ),
                  Text(
                    child['class']!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected
                          ? AppColors.navyLight
                          : AppColors.darkGray,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChildOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.softCard,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOverviewItem(
                'Attendance',
                '95.5%',
                Icons.check_circle_rounded,
                AppColors.success,
              ),
              _buildOverviewItem(
                'Grade',
                'A-',
                Icons.star_rounded,
                AppColors.warning,
              ),
              _buildOverviewItem(
                'Behavior',
                'Good',
                Icons.emoji_emotions_rounded,
                AppColors.info,
              ),
            ],
          ),
          AppSpacing.heightXl,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.info,
                  size: 20,
                ),
                AppSpacing.widthSm,
                Expanded(
                  child: Text(
                    'Next parent-teacher meeting on March 15, 2024',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
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
        AppSpacing.heightSm,
        Text(
          value,
          style: AppTextStyles.h3,
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'title': 'View Report Card',
        'icon': Icons.description_rounded,
        'color': AppColors.info,
      },
      {
        'title': 'Pay Fees',
        'icon': Icons.payment_rounded,
        'color': AppColors.success,
      },
      {
        'title': 'Message Teacher',
        'icon': Icons.message_rounded,
        'color': AppColors.warning,
      },
      {
        'title': 'View Schedule',
        'icon': Icons.calendar_today_rounded,
        'color': AppColors.primaryMint,
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3,
      children: actions.map((action) {
        return InkWell(
          onTap: () {
            // Handle action
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.mediumGray,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  action['icon'] as IconData,
                  color: action['color'] as Color,
                  size: 20,
                ),
                AppSpacing.widthSm,
                Expanded(
                  child: Text(
                    action['title'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentUpdates() {
    final updates = [
      {
        'title': 'Excellent Performance',
        'subtitle': 'Sarah scored 95% in Mathematics test',
        'time': '2 hours ago',
        'type': 'achievement',
      },
      {
        'title': 'Attendance Alert',
        'subtitle': 'Michael was 10 minutes late today',
        'time': '5 hours ago',
        'type': 'warning',
      },
      {
        'title': 'Fee Reminder',
        'subtitle': 'Term 2 fees due by March 20',
        'time': 'Yesterday',
        'type': 'payment',
      },
      {
        'title': 'Event Notification',
        'subtitle': 'Annual Sports Day on March 25',
        'time': '2 days ago',
        'type': 'event',
      },
    ];

    return Column(
      children: updates.map((update) {
        IconData icon;
        Color color;
        
        switch (update['type']) {
          case 'achievement':
            icon = Icons.emoji_events_rounded;
            color = AppColors.success;
            break;
          case 'warning':
            icon = Icons.warning_rounded;
            color = AppColors.warning;
            break;
          case 'payment':
            icon = Icons.payment_rounded;
            color = AppColors.info;
            break;
          default:
            icon = Icons.event_rounded;
            color = AppColors.primaryMint;
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              AppSpacing.widthMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      update['title'] as String,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      update['subtitle'] as String,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                update['time'] as String,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}