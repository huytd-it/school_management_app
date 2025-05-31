import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';

/// Dashboard statistics card with modern design
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? accentColor;
  final String? trend;
  final bool? trendUp;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.accentColor,
    this.trend,
    this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primaryMint;
    
    return Container(
      decoration: AppDecorations.softCard,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              if (trend != null && trendUp != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: trendUp!
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendUp!
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        color: trendUp! ? AppColors.success : AppColors.error,
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend!,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: trendUp! ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}