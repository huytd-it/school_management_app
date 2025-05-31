import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  final String route;
  final bool isExpandable;
  final List<SidebarItem>? children;

  SidebarItem({
    required this.title,
    required this.icon,
    required this.route,
    this.isExpandable = false,
    this.children,
  });
}

class LeftSidebar extends StatefulWidget {
  final List<SidebarItem> items;
  final String selectedRoute;
  final Function(String) onItemSelected;
  final String userName;
  final String userRole;
  final String? userImageUrl;
  final VoidCallback onLogout;

  const LeftSidebar({
    Key? key,
    required this.items,
    required this.selectedRoute,
    required this.onItemSelected,
    required this.userName,
    required this.userRole,
    this.userImageUrl,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  final Set<String> _expandedItems = {};

  void _toggleExpanded(String title) {
    setState(() {
      if (_expandedItems.contains(title)) {
        _expandedItems.remove(title);
      } else {
        _expandedItems.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  ...widget.items.map((item) => _buildSidebarItem(item, 0)),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryMint,
              borderRadius: BorderRadius.circular(12),
              image: widget.userImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(widget.userImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.userImageUrl == null
                ? Center(
                    child: Text(
                      widget.userName.isNotEmpty
                          ? widget.userName.substring(0, 1).toUpperCase()
                          : 'U',
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.primaryNavy,
                      ),
                    ),
                  )
                : null,
          ),
          AppSpacing.widthMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.userRole,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.darkGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(SidebarItem item, int level) {
    final isSelected = widget.selectedRoute == item.route;
    final isExpanded = _expandedItems.contains(item.title);
    final hasChildren = item.isExpandable && (item.children != null && item.children!.isNotEmpty);

    if (hasChildren) {
      return Column(
        children: [
          _buildItemButton(
            title: item.title,
            icon: item.icon,
            isSelected: isSelected,
            isExpandable: true,
            isExpanded: isExpanded,
            level: level,
            onTap: () => widget.onItemSelected(item.route),
            onExpandTap: () => _toggleExpanded(item.title),
          ),
          if (isExpanded)
            ...item.children!.map((child) => _buildSidebarItem(child, level + 1)),
        ],
      );
    }

    return _buildItemButton(
      title: item.title,
      icon: item.icon,
      isSelected: isSelected,
      isExpandable: false,
      isExpanded: false,
      level: level,
      onTap: () => widget.onItemSelected(item.route),
    );
  }

  Widget _buildItemButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required bool isExpandable,
    required bool isExpanded,
    required int level,
    required VoidCallback onTap,
    VoidCallback? onExpandTap,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 16.0 * level, right: 16, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryMint.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected ? AppColors.primaryNavy : AppColors.darkGray,
                      ),
                      AppSpacing.widthMd,
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected ? AppColors.primaryNavy : AppColors.charcoal,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isExpandable)
              InkWell(
                onTap: onExpandTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          const Divider(height: 1, thickness: 1),
          AppSpacing.heightMd,
          InkWell(
            onTap: widget.onLogout,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                    size: 20,
                  ),
                  AppSpacing.widthSm,
                  Text(
                    'Logout',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
