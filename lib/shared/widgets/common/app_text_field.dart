import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';

/// App text field component with consistent styling and validation
/// Supports various input types, validation, and customization
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final AppTextFieldSize size;
  final AppTextFieldVariant variant;
  final EdgeInsetsGeometry? margin;
  final bool showCharacterCount;
  final FocusNode? focusNode;
  final bool autovalidateMode;
  final Color? fillColor;
  final double? borderRadius;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.filled,
    this.margin,
    this.showCharacterCount = false,
    this.focusNode,
    this.autovalidateMode = false,
    this.fillColor,
    this.borderRadius,
  });

  /// Email text field constructor
  const AppTextField.email({
    super.key,
    this.label,
    this.hintText = 'Enter your email',
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.filled,
    this.margin,
    this.focusNode,
    this.autovalidateMode = false,
    this.fillColor,
    this.borderRadius,
  }) : keyboardType = TextInputType.emailAddress,
       obscureText = false,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       inputFormatters = null,
       prefixText = null,
       suffixText = null,
       showCharacterCount = false;

  /// Password text field constructor
  const AppTextField.password({
    super.key,
    this.label,
    this.hintText = 'Enter your password',
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.filled,
    this.margin,
    this.focusNode,
    this.autovalidateMode = false,
    this.fillColor,
    this.borderRadius,
  }) : keyboardType = TextInputType.visiblePassword,
       obscureText = true,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       inputFormatters = null,
       suffixIcon = null,
       prefixText = null,
       suffixText = null,
       showCharacterCount = false;

  /// Phone text field constructor
  const AppTextField.phone({
    super.key,
    this.label,
    this.hintText = 'Enter phone number',
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.filled,
    this.margin,
    this.focusNode,
    this.autovalidateMode = false,
    this.fillColor,
    this.borderRadius,
  }) : keyboardType = TextInputType.phone,
       obscureText = false,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       inputFormatters = null,
       prefixText = null,
       suffixText = null,
       showCharacterCount = false;

  /// Multiline text field constructor
  const AppTextField.multiline({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.textInputAction = TextInputAction.newline,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 4,
    this.minLines = 3,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.filled,
    this.margin,
    this.showCharacterCount = true,
    this.focusNode,
    this.autovalidateMode = false,
    this.fillColor,
    this.borderRadius,
  }) : keyboardType = TextInputType.multiline,
       obscureText = false,
       inputFormatters = null,
       prefixText = null,
       suffixText = null;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _errorText = widget.errorText;

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.autovalidateMode && widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_controller.text);
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_controller.text);
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onSubmitted,
      style: _getTextStyle(),
      decoration: _getInputDecoration(),
      validator: widget.autovalidateMode ? null : widget.validator,
    );

    if (widget.label != null) {
      textField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: _getLabelStyle(),
          ),
          const SizedBox(height: AppDimensions.xs),
          textField,
        ],
      );
    }

    if (widget.margin != null) {
      textField = Padding(
        padding: widget.margin!,
        child: textField,
      );
    }

    return textField;
  }

  InputDecoration _getInputDecoration() {
    return AppDecorations.inputDecoration(
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: _errorText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _getSuffixIcon(),
      enabled: widget.enabled,
    ).copyWith(
      fillColor: widget.fillColor,
      border: _getBorder(),
      enabledBorder: _getBorder(),
      focusedBorder: _getFocusedBorder(),
      errorBorder: _getErrorBorder(),
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      counterText: widget.showCharacterCount ? null : '',
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.darkGray,
          size: _getIconSize(),
        ),
        onPressed: _togglePasswordVisibility,
      );
    }
    return widget.suffixIcon;
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? _getBorderRadius(),
      ),
      borderSide: BorderSide(
        color: _getBorderColor(),
        width: 1,
      ),
    );
  }

  OutlineInputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? _getBorderRadius(),
      ),
      borderSide: const BorderSide(
        color: AppColors.primaryMint,
        width: 2,
      ),
    );
  }

  OutlineInputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? _getBorderRadius(),
      ),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    );
  }

  TextStyle _getTextStyle() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return AppTextStyles.bodySmall;
      case AppTextFieldSize.medium:
        return AppTextStyles.bodyMedium;
      case AppTextFieldSize.large:
        return AppTextStyles.bodyLarge;
    }
  }

  TextStyle _getLabelStyle() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return AppTextStyles.labelSmall;
      case AppTextFieldSize.medium:
        return AppTextStyles.labelMedium;
      case AppTextFieldSize.large:
        return AppTextStyles.labelLarge;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return AppDimensions.radiusSmall;
      case AppTextFieldSize.medium:
        return AppDimensions.radiusMedium;
      case AppTextFieldSize.large:
        return AppDimensions.radiusLarge;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return AppDimensions.iconSmall;
      case AppTextFieldSize.medium:
        return AppDimensions.iconMedium;
      case AppTextFieldSize.large:
        return AppDimensions.iconLarge;
    }
  }

  Color _getBorderColor() {
    switch (widget.variant) {
      case AppTextFieldVariant.filled:
        return AppColors.mediumGray;
      case AppTextFieldVariant.outlined:
        return AppColors.darkGray;
    }
  }
}

/// Text field size enumeration
enum AppTextFieldSize {
  small,
  medium,
  large,
}

/// Text field variant enumeration
enum AppTextFieldVariant {
  filled,
  outlined,
}