import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/module_model.dart';
import '../../widgets/common/custom_app_bar.dart';

class ModuleDetailScreen extends StatefulWidget {
  final String moduleId;
  
  const ModuleDetailScreen({
    Key? key,
    required this.moduleId,
  }) : super(key: key);
  
  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ModuleModel _module;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Find the module by ID
    _module = getModules().firstWhere(
      (module) => module.id == widget.moduleId,
      orElse: () => getModules().first,
    );
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _module.title,
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show module options
              _showModuleOptions(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8FCF8), Colors.white],
          ),
        ),
        child: Column(
          children: [
            _buildModuleHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildDetailsTab(),
                  _buildActivityTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item action
          _showAddItemDialog(context);
        },
        backgroundColor: _module.accentColor,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildModuleHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _module.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _module.icon,
                  color: _module.accentColor,
                  size: 24,
                ),
              ),
              AppSpacing.widthMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _module.title,
                      style: AppTextStyles.h3,
                    ),
                    Text(
                      _module.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.heightLg,
          Row(
            children: _module.stats.map((stat) {
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: _module.accentColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    stat,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: _module.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: _module.accentColor,
        unselectedLabelColor: AppColors.darkGray,
        indicatorColor: _module.accentColor,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Details'),
          Tab(text: 'Activity'),
        ],
      ),
    );
  }
  
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          Text(
            'This is the overview tab for the ${_module.title} module. '
            'It provides a summary of the module\'s functionality and key metrics.',
            style: AppTextStyles.bodyMedium,
          ),
          AppSpacing.heightXl,
          
          // Quick stats
          Text('Quick Stats', style: AppTextStyles.h4),
          AppSpacing.heightMd,
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('Total Items', '1,234', Icons.inventory_2_rounded),
              _buildStatCard('Active Users', '89', Icons.people_rounded),
              _buildStatCard('This Month', '45', Icons.calendar_today_rounded),
              _buildStatCard('Pending', '12', Icons.pending_actions_rounded),
            ],
          ),
          
          AppSpacing.heightXl,
          
          // Recent items
          Text('Recent Items', style: AppTextStyles.h4),
          AppSpacing.heightMd,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _module.accentColor.withOpacity(0.1),
                  child: Icon(_module.icon, color: _module.accentColor, size: 20),
                ),
                title: Text('Item ${index + 1}'),
                subtitle: Text('Last updated: ${index + 1} hour(s) ago'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to item details
                },
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          Text(
            'This is the details tab for the ${_module.title} module. '
            'It provides detailed information about the module\'s configuration and settings.',
            style: AppTextStyles.bodyMedium,
          ),
          AppSpacing.heightXl,
          
          // Module settings
          Text('Module Settings', style: AppTextStyles.h4),
          AppSpacing.heightMd,
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.mediumGray),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSettingItem('Notifications', true),
                const Divider(height: 1),
                _buildSettingItem('Auto-sync', false),
                const Divider(height: 1),
                _buildSettingItem('Data Backup', true),
                const Divider(height: 1),
                _buildSettingItem('Analytics', true),
              ],
            ),
          ),
          
          AppSpacing.heightXl,
          
          // Module permissions
          Text('Permissions', style: AppTextStyles.h4),
          AppSpacing.heightMd,
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.mediumGray),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPermissionItem('Admin', 'Full access', AppColors.success),
                const Divider(height: 1),
                _buildPermissionItem('Teacher', 'Edit access', AppColors.info),
                const Divider(height: 1),
                _buildPermissionItem('Student', 'View only', AppColors.warning),
                const Divider(height: 1),
                _buildPermissionItem('Parent', 'View only', AppColors.warning),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity Log', style: AppTextStyles.h3),
          AppSpacing.heightMd,
          Text(
            'This is the activity tab for the ${_module.title} module. '
            'It shows a log of recent activities and changes.',
            style: AppTextStyles.bodyMedium,
          ),
          AppSpacing.heightXl,
          
          // Activity log
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final actions = [
                'added a new item',
                'updated an item',
                'deleted an item',
                'changed settings',
                'exported data',
              ];
              final users = [
                'Admin User',
                'John Teacher',
                'Sarah Admin',
                'Mike Staff',
                'Lisa Manager',
              ];
              final action = actions[index % actions.length];
              final user = users[index % users.length];
              final timeAgo = '${index + 1} hour(s) ago';
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: _module.accentColor.withOpacity(0.1),
                      child: Text(
                        user.substring(0, 1),
                        style: TextStyle(
                          color: _module.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AppSpacing.widthMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.charcoal,
                              ),
                              children: [
                                TextSpan(
                                  text: user,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' $action'),
                              ],
                            ),
                          ),
                          AppSpacing.heightXs,
                          Text(
                            timeAgo,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _module.accentColor,
                size: 20,
              ),
              AppSpacing.widthSm,
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
          AppSpacing.heightSm,
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingItem(String title, bool isEnabled) {
    return SwitchListTile(
      title: Text(title),
      value: isEnabled,
      onChanged: (value) {
        // Update setting
      },
      activeColor: _module.accentColor,
    );
  }
  
  Widget _buildPermissionItem(String role, String access, Color color) {
    return ListTile(
      title: Text(role),
      subtitle: Text(access),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          access,
          style: AppTextStyles.caption.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  void _showModuleOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: _module.accentColor),
                title: const Text('Edit Module'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to edit module screen
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: _module.accentColor),
                title: const Text('Module Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to module settings screen
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: _module.accentColor),
                title: const Text('Share Module'),
                onTap: () {
                  Navigator.pop(context);
                  // Share module
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: AppColors.info),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to help screen
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New ${_module.title} Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Item Name',
                hintText: 'Enter item name',
              ),
            ),
            AppSpacing.heightMd,
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add new item
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('New item added successfully'),
                  backgroundColor: _module.accentColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _module.accentColor,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}