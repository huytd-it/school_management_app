import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/module_model.dart';
import '../../widgets/dashboard/quick_stats_card.dart';
import '../../widgets/dashboard/recent_activity_item.dart';
import '../../widgets/dashboard/welcome_header.dart';
import '../../widgets/dashboard/dashboard_card.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final List<RecentActivity> _recentActivities = getRecentActivities();
  final List<QuickStat> _quickStats = getQuickStats();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            AppSpacing.heightXxl,
            _buildQuickStats(),
            AppSpacing.heightXxl,
            _buildOverviewCards(),
            AppSpacing.heightXxl,
            _buildRecentActivity(),
            AppSpacing.heightXxl,
            _buildQuickActions(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: AppColors.lightGray,
        highlightColor: Colors.white,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return WelcomeHeader(
      userName: 'Admin User',
      userRole: 'School Administrator',
      notificationCount: 5,
      onNotificationTap: () {},
      onProfileTap: () {},
    );
  }

  Widget _buildQuickStats() {
    if (_isLoading) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: _getQuickStatsCrossAxisCount(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: List.generate(4, (index) => const QuickStatsShimmer()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Stats', style: AppTextStyles.h3),
        AppSpacing.heightMd,
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: _getQuickStatsCrossAxisCount(context),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: _quickStats.map((stat) => 
            QuickStatsCard(
              title: stat.title,
              value: stat.value,
              icon: stat.icon,
              color: stat.color,
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildOverviewCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: AppTextStyles.h3),
        AppSpacing.heightMd,
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
      ],
    );
  }

  Widget _buildRecentActivity() {
    if (_isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: const RecentActivityShimmer(),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: AppTextStyles.h3),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.heightMd,
        ...List.generate(
          _recentActivities.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RecentActivityItem(
              title: _recentActivities[index].title,
              description: _recentActivities[index].description,
              time: _recentActivities[index].time,
              icon: _recentActivities[index].icon,
              color: _recentActivities[index].color,
              onTap: () {
                // Navigate to related module or detail
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: AppTextStyles.h3),
        AppSpacing.heightMd,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildActionButton(
              'Add Student',
              Icons.person_add_rounded,
              AppColors.info,
              () {
                // Navigate to add student
              },
            ),
            _buildActionButton(
              'Create Notice',
              Icons.campaign_rounded,
              AppColors.warning,
              () {
                // Navigate to create notice
              },
            ),
            _buildActionButton(
              'View Reports',
              Icons.analytics_rounded,
              AppColors.success,
              () {
                // Navigate to reports
              },
            ),
            _buildActionButton(
              'Manage Classes',
              Icons.class_rounded,
              AppColors.primaryMint,
              () {
                // Navigate to manage classes
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            AppSpacing.widthSm,
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getQuickStatsCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 4;
    if (width > 600) return 2;
    return 2;
  }
}