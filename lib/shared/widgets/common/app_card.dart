import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_decorations.dart';

/// App card component with consistent styling and multiple variants
/// Provides different elevation levels, colors, and interaction states
class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final AppCardVariant variant;
  final AppCardElevation elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final bool isSelected;
  final bool isDisabled;
  final Widget? header;
  final Widget? footer;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.variant = AppCardVariant.filled,
    this.elevation = AppCardElevation.medium,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isSelected = false,
    this.isDisabled = false,
    this.header,
    this.footer,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
  });

  /// Filled card constructor
  const AppCard.filled({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevation = AppCardElevation.medium,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isSelected = false,
    this.isDisabled = false,
    this.header,
    this.footer,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
  }) : variant = AppCardVariant.filled;

  /// Outlined card constructor
  const AppCard.outlined({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isSelected = false,
    this.isDisabled = false,
    this.header,
    this.footer,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
  }) : variant = AppCardVariant.outlined,
       elevation = AppCardElevation.none;

  /// Elevated card constructor
  const AppCard.elevated({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isSelected = false,
    this.isDisabled = false,
    this.header,
    this.footer,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
  }) : variant = AppCardVariant.filled,
       elevation = AppCardElevation.high;

  /// Glass card constructor (semi-transparent)
  const AppCard.glass({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isSelected = false,
    this.isDisabled = false,
    this.header,
    this.footer,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
  }) : variant = AppCardVariant.glass,
       elevation = AppCardElevation.low,
       backgroundColor = null;

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: _getDecoration(),
      padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
      child: _buildContent(),
    );

    if (onTap != null || onLongPress != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          onLongPress: isDisabled ? null : onLongPress,
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          child: card,
        ),
      );
    }

    if (margin != null) {
      card = Padding(
        padding: margin!,
        child: card,
      );
    }

    return card;
  }

  Widget _buildContent() {
    final children = <Widget>[];

    if (header != null) {
      children.add(header!);
      children.add(const SizedBox(height: AppDimensions.sm));
    }

    children.add(child);

    if (footer != null) {
      children.add(const SizedBox(height: AppDimensions.sm));
      children.add(footer!);
    }

    if (children.length == 1) {
      return children.first;
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      children: children,
    );
  }

  BoxDecoration _getDecoration() {
    switch (variant) {
      case AppCardVariant.filled:
        return _getFilledDecoration();
      case AppCardVariant.outlined:
        return _getOutlinedDecoration();
      case AppCardVariant.glass:
        return _getGlassDecoration();
    }
  }

  BoxDecoration _getFilledDecoration() {
    return BoxDecoration(
      color: _getBackgroundColor(),
      borderRadius: BorderRadius.circular(_getBorderRadius()),
      boxShadow: _getBoxShadow(),
      border: isSelected ? _getSelectionBorder() : null,
    );
  }

  BoxDecoration _getOutlinedDecoration() {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.white,
      borderRadius: BorderRadius.circular(_getBorderRadius()),
      border: _getBorder(),
      boxShadow: _getBoxShadow(),
    );
  }

  BoxDecoration _getGlassDecoration() {
    return BoxDecoration(
      color: AppColors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(_getBorderRadius()),
      border: Border.all(
        color: AppColors.white.withOpacity(0.2),
        width: borderWidth ?? 1,
      ),
      boxShadow: _getBoxShadow(),
    );
  }

  Color _getBackgroundColor() {
    if (isDisabled) {
      return AppColors.lightGray;
    }
    if (isSelected) {
      return backgroundColor ?? AppColors.primaryMint.withOpacity(0.1);
    }
    return backgroundColor ?? AppColors.white;
  }

  double _getBorderRadius() {
    return borderRadius ?? AppDimensions.radiusMedium;
  }

  Border? _getBorder() {
    if (isSelected) {
      return _getSelectionBorder();
    }
    return Border.all(
      color: borderColor ?? AppColors.mediumGray,
      width: borderWidth ?? 1,
    );
  }

  Border _getSelectionBorder() {
    return Border.all(
      color: AppColors.primaryMint,
      width: 2,
    );
  }

  List<BoxShadow>? _getBoxShadow() {
    if (isDisabled) {
      return null;
    }

    switch (elevation) {
      case AppCardElevation.none:
        return null;
      case AppCardElevation.low:
        return [AppDecorations.softShadow];
      case AppCardElevation.medium:
        return [AppDecorations.cardShadow];
      case AppCardElevation.high:
        return [AppDecorations.elevatedShadow];
    }
  }
}

/// Card variant enumeration
enum AppCardVariant {
  filled,
  outlined,
  glass,
}

/// Card elevation enumeration
enum AppCardElevation {
  none,
  low,
  medium,
  high,
}

/// Card header widget for consistent styling
class AppCardHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTrailingPressed;

  const AppCardHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) ..[
          leading!,
          const SizedBox(width: AppDimensions.sm),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ..[
                const SizedBox(height: AppDimensions.xs),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ..[
          const SizedBox(width: AppDimensions.sm),
          if (onTrailingPressed != null)
            GestureDetector(
              onTap: onTrailingPressed,
              child: trailing!,
            )
          else
            trailing!,
        ],
      ],
    );
  }
}

/// Card footer widget for consistent styling
class AppCardFooter extends StatelessWidget {
  final List<Widget> actions;
  final MainAxisAlignment alignment;
  final bool isFullWidth;

  const AppCardFooter({
    super.key,
    required this.actions,
    this.alignment = MainAxisAlignment.end,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullWidth && actions.length == 1) {
      return SizedBox(
        width: double.infinity,
        child: actions.first,
      );
    }

    return Row(
      mainAxisAlignment: alignment,
      children: actions
          .expand(
            (action) => [
              action,
              if (action != actions.last)
                const SizedBox(width: AppDimensions.sm),
            ],
          )
          .toList(),
    );
  }
}", "original_text": "placeholder", "replace_all": false}]