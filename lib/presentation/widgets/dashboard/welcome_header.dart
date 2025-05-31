import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class WelcomeHeader extends StatelessWidget {
  final String userName;
  final String userRole;
  final String? userImageUrl;
  final int notificationCount;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;

  const WelcomeHeader({
    Key? key,
    required this.userName,
    required this.userRole,
    this.userImageUrl,
    required this.notificationCount,
    required this.onNotificationTap,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
                AppSpacing.heightXs,
                Text(
                  userName,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
                AppSpacing.heightXs,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryMint.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    userRole,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryNavy,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: onNotificationTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: AppColors.primaryNavy,
                        size: 24,
                      ),
                      if (notificationCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              notificationCount > 9 ? '9+' : notificationCount.toString(),
                              style: AppTextStyles.overline.copyWith(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              AppSpacing.widthMd,
              InkWell(
                onTap: onProfileTap,
                borderRadius: BorderRadius.circular(30),
                child: userImageUrl != null && userImageUrl!.isNotEmpty
                    ? CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(userImageUrl!),
                      )
                    : CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryMint,
                        child: Text(
                          userName.isNotEmpty
                              ? userName.substring(0, 1).toUpperCase()
                              : 'U',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.primaryNavy,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}