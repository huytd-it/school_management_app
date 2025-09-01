import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../features/auth/presentation/bloc/auth_state.dart';
import 'simplified_navigation.dart';
import 'modern_bottom_nav.dart';

/// Simplified app layout that replaces the complex responsive layout
/// Focuses on mobile-first design with bottom navigation
class SimplifiedAppLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final int selectedIndex;
  final ValueChanged<int> onNavigationChanged;
  final List<Widget>? actions;
  final bool showBackButton;

  const SimplifiedAppLayout({
    super.key,
    required this.body,
    required this.title,
    required this.selectedIndex,
    required this.onNavigationChanged,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: body,
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.primaryNavy,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Text(
                  'Welcome, ${state.user.name}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.darkGray,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      actions: [
        ...SimplifiedNavigation.getAppBarActions(context),
        _buildUserAvatar(context),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.lightGray.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return GestureDetector(
            onTap: () => _showUserMenu(context),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryMint,
                backgroundImage: state.user.photoUrl != null
                    ? NetworkImage(state.user.photoUrl!)
                    : null,
                child: state.user.photoUrl == null
                    ? Text(
                        state.user.name.isNotEmpty
                            ? state.user.name[0].toUpperCase()
                            : 'U',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildUserMenuSheet(context),
    );
  }

  Widget _buildUserMenuSheet(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! AuthAuthenticated) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              
              // User Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primaryMint,
                    backgroundImage: state.user.photoUrl != null
                        ? NetworkImage(state.user.photoUrl!)
                        : null,
                    child: state.user.photoUrl == null
                        ? Text(
                            state.user.name.isNotEmpty
                                ? state.user.name[0].toUpperCase()
                                : 'U',
                            style: AppTextStyles.h4.copyWith(
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.name,
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state.user.email,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkGray,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryMint.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            state.user.role.toUpperCase(),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Menu Items
              ...SimplifiedNavigation.getUserMenuItems().map((item) {
                return _buildMenuItem(
                  context,
                  item.icon,
                  item.title,
                  item.onTap,
                  isDestructive: item.isDestructive,
                );
              }).toList(),
              
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    {bool isDestructive = false}
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.darkGray,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isDestructive ? AppColors.error : AppColors.primaryNavy,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (title == 'Logout') {
          // Handle logout specifically
          context.read<AuthBloc>().add(const AuthLogoutRequested());
        } else {
          onTap();
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ModernBottomNav(
          items: SimplifiedNavigation.getBottomNavItems(),
          selectedIndex: selectedIndex,
          onItemSelected: onNavigationChanged,
        ),
      ),
    );
  }
}