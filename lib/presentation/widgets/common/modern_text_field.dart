import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';

/// Modern text field widget with consistent styling
class ModernTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool enabled;
  final String? initialValue;

  const ModernTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryNavy,
          ),
        ),
        AppSpacing.heightSm,
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          maxLines: obscureText ? 1 : maxLines,
          enabled: enabled,
          initialValue: initialValue,
          style: AppTextStyles.bodyLarge.copyWith(
            color: enabled ? AppColors.charcoal : AppColors.darkGray,
          ),
          decoration: AppDecorations.textFieldDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.darkGray,
                    size: 20,
                  )
                : null,
            suffixIcon: suffixIcon,
          ).copyWith(
            fillColor: enabled ? AppColors.lightGray : AppColors.mediumGray,
          ),
        ),
      ],
    );
  }
}