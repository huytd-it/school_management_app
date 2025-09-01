import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// App button component with consistent styling and multiple variants
/// Supports different sizes, styles, and states
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isEnabled;
  final Widget? icon;
  final bool isFullWidth;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  /// Primary button constructor
  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.primary;

  /// Secondary button constructor
  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.secondary;

  /// Outlined button constructor
  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.outlined;

  /// Text button constructor
  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.text;

  /// Danger button constructor
  const AppButton.danger({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.isFullWidth = false,
    this.margin,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : variant = AppButtonVariant.danger;

  @override
  Widget build(BuildContext context) {
    final isDisabled = !isEnabled || isLoading;
    final effectiveOnPressed = isDisabled ? null : onPressed;

    Widget button = _buildButton(effectiveOnPressed);

    if (isFullWidth) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    if (margin != null) {
      button = Padding(
        padding: margin!,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButton(VoidCallback? effectiveOnPressed) {
    switch (variant) {
      case AppButtonVariant.primary:
        return _buildElevatedButton(effectiveOnPressed);
      case AppButtonVariant.secondary:
        return _buildSecondaryButton(effectiveOnPressed);
      case AppButtonVariant.outlined:
        return _buildOutlinedButton(effectiveOnPressed);
      case AppButtonVariant.text:
        return _buildTextButton(effectiveOnPressed);
      case AppButtonVariant.danger:
        return _buildDangerButton(effectiveOnPressed);
    }
  }

  Widget _buildElevatedButton(VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryMint,
        foregroundColor: textColor ?? AppColors.primaryNavy,
        disabledBackgroundColor: AppColors.disabled,
        disabledForegroundColor: AppColors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getButtonRadius(),
          ),
        ),
        padding: _getButtonPadding(),
        minimumSize: Size(0, _getButtonHeight()),
      ),
      child: _buildButtonChild(),
    );
  }

  Widget _buildSecondaryButton(VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.white,
        foregroundColor: textColor ?? AppColors.primaryNavy,
        disabledBackgroundColor: AppColors.lightGray,
        disabledForegroundColor: AppColors.disabled,
        elevation: 0,
        shadowColor: Colors.transparent,
        side: const BorderSide(color: AppColors.primaryMint, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getButtonRadius(),
          ),
        ),
        padding: _getButtonPadding(),
        minimumSize: Size(0, _getButtonHeight()),
      ),
      child: _buildButtonChild(),
    );
  }

  Widget _buildOutlinedButton(VoidCallback? onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primaryNavy,
        disabledForegroundColor: AppColors.disabled,
        side: BorderSide(
          color: backgroundColor ?? AppColors.mediumGray,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getButtonRadius(),
          ),
        ),
        padding: _getButtonPadding(),
        minimumSize: Size(0, _getButtonHeight()),
      ),
      child: _buildButtonChild(),
    );
  }

  Widget _buildTextButton(VoidCallback? onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primaryNavy,
        disabledForegroundColor: AppColors.disabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getButtonRadius(),
          ),
        ),
        padding: _getButtonPadding(),
        minimumSize: Size(0, _getButtonHeight()),
      ),
      child: _buildButtonChild(),
    );
  }

  Widget _buildDangerButton(VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.error,
        foregroundColor: textColor ?? AppColors.white,
        disabledBackgroundColor: AppColors.disabled,
        disabledForegroundColor: AppColors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getButtonRadius(),
          ),
        ),
        padding: _getButtonPadding(),
        minimumSize: Size(0, _getButtonHeight()),
      ),
      child: _buildButtonChild(),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getLoadingIndicatorColor(),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: AppDimensions.xs),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.buttonSmall;
      case AppButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case AppButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeightSmall;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeightMedium;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.sm,
          vertical: AppDimensions.xs,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.sm,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.lg,
          vertical: AppDimensions.md,
        );
    }
  }

  double _getButtonRadius() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.radiusSmall;
      case AppButtonSize.medium:
        return AppDimensions.radiusMedium;
      case AppButtonSize.large:
        return AppDimensions.radiusLarge;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.iconSmall;
      case AppButtonSize.medium:
        return AppDimensions.iconMedium;
      case AppButtonSize.large:
        return AppDimensions.iconLarge;
    }
  }

  Color _getLoadingIndicatorColor() {
    switch (variant) {
      case AppButtonVariant.primary:
        return textColor ?? AppColors.primaryNavy;
      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
      case AppButtonVariant.text:
        return textColor ?? AppColors.primaryNavy;
      case AppButtonVariant.danger:
        return textColor ?? AppColors.white;
    }
  }
}

/// Button variant enumeration
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  danger,
}

/// Button size enumeration
enum AppButtonSize {
  small,
  medium,
  large,
}", "original_text": "placeholder", "replace_all": false}]