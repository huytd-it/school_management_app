import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/module_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/dashboard/module_card.dart';
import '../../widgets/dashboard/quick_stats_card.dart';
import '../../widgets/dashboard/recent_activity_item.dart';
import '../../widgets/dashboard/search_filter_bar.dart';
import '../../widgets/dashboard/welcome_header.dart';

class ModuleDashboard extends StatefulWidget {
  const ModuleDashboard({Key? key}) : super(key: key);

  @override
  State<ModuleDashboard> createState() => _ModuleDashboardState();
}

class _ModuleDashboardState extends State<ModuleDashboard> {
  final TextEditingController _searchController = TextEditingController();
  final List<ModuleModel> _allModules = getModules();
  final List<RecentActivity> _recentActivities = getRecentActivities();
  final List<QuickStat> _quickStats = getQuickStats();
  
  List<ModuleModel> _filteredModules = [];
  String _selectedCategory = '';
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _filteredModules = _allModules;
    
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _filterModules(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory.isEmpty) {
        _filteredModules = _allModules;
      } else {
        _filteredModules = _allModules.where((module) {
          final matchesQuery = query.isEmpty || 
              module.title.toLowerCase().contains(query.toLowerCase()) ||
              module.description.toLowerCase().contains(query.toLowerCase());
          
          final matchesCategory = _selectedCategory.isEmpty || 
              module.category == _selectedCategory;
          
          return matchesQuery && matchesCategory;
        }).toList();
      }
    });
  }
  
  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? '' : category;
      _filterModules(_searchController.text);
    });
  }
  
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Modules', style: AppTextStyles.h3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            AppSpacing.heightMd,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildCategoryChip(ModuleCategory.academic),
                _buildCategoryChip(ModuleCategory.administrative),
                _buildCategoryChip(ModuleCategory.financial),
                _buildCategoryChip(ModuleCategory.communication),
                _buildCategoryChip(ModuleCategory.support),
                _buildCategoryChip(ModuleCategory.system),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = '';
                _filterModules(_searchController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Clear Filters'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryMint,
              foregroundColor: AppColors.primaryNavy,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    
    return FilterChip(
      label: Text(category),
      selected: isSelected,
      onSelected: (selected) {
        _filterByCategory(category);
        Navigator.pop(context);
      },
      backgroundColor: Colors.white,
      selectedColor: AppColors.primaryMint,
      checkmarkColor: AppColors.primaryNavy,
      labelStyle: AppTextStyles.bodySmall.copyWith(
        color: isSelected ? AppColors.primaryNavy : AppColors.darkGray,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryMint : AppColors.mediumGray,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'School Management',
        showBackButton: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8FCF8), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(),
                AppSpacing.heightXxl,
                _buildQuickStats(),
                AppSpacing.heightXxl,
                SearchFilterBar(
                  controller: _searchController,
                  onChanged: _filterModules,
                  onFilterTap: _showFilterDialog,
                ),
                AppSpacing.heightXl,
                _buildModuleGrid(),
                AppSpacing.heightXxl,
                _buildRecentActivity(),
              ],
            ),
          ),
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
  
  int _getQuickStatsCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 4;
    if (width > 600) return 2;
    return 2;
  }
  
  Widget _buildModuleGrid() {
    if (_isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Modules', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: _getModuleGridCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: List.generate(6, (index) => const ModuleCardShimmer()),
          ),
        ],
      );
    }
    
    if (_filteredModules.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Modules', style: AppTextStyles.h3),
          AppSpacing.heightXl,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64,
                  color: AppColors.darkGray.withOpacity(0.5),
                ),
                AppSpacing.heightMd,
                Text(
                  'No modules found',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
                AppSpacing.heightSm,
                Text(
                  'Try adjusting your search or filters',
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
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Modules', style: AppTextStyles.h3),
            if (_selectedCategory.isNotEmpty)
              Chip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_selectedCategory),
                    AppSpacing.widthXs,
                    const Icon(Icons.close, size: 16),
                  ],
                ),
                backgroundColor: AppColors.primaryMint.withOpacity(0.2),
                labelStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryNavy,
                ),
                onDeleted: () {
                  setState(() {
                    _selectedCategory = '';
                    _filterModules(_searchController.text);
                  });
                },
                deleteIconColor: AppColors.primaryNavy,
              ),
          ],
        ),
        AppSpacing.heightMd,
        AnimationLimiter(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: _getModuleGridCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: List.generate(
              _filteredModules.length,
              (index) => AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 300),
                columnCount: _getModuleGridCrossAxisCount(context),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ModuleCard(
                      title: _filteredModules[index].title,
                      description: _filteredModules[index].description,
                      icon: _filteredModules[index].icon,
                      accentColor: _filteredModules[index].accentColor,
                      stats: _filteredModules[index].stats,
                      isActive: _filteredModules[index].isActive,
                      onTap: () => _navigateToModule(_filteredModules[index].route),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  int _getModuleGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
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
                final moduleId = _recentActivities[index].moduleId;
                final module = _allModules.firstWhere((m) => m.id == moduleId);
                _navigateToModule(module.route);
              },
            ),
          ),
        ),
      ],
    );
  }
  
  void _navigateToModule(String route) {
    // This would use your app's navigation system
    // For now, just print the route
    print('Navigating to: $route');
  }
}

// Placeholder module detail screen
class ModuleDetailScreen extends StatelessWidget {
  final String moduleId;
  
  const ModuleDetailScreen({
    Key? key,
    required this.moduleId,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Module Details',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Module Detail Screen: $moduleId', style: AppTextStyles.h2),
      ),
    );
  }
}