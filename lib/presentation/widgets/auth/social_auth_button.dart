import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

/// Social authentication button widget
class SocialAuthButton extends StatelessWidget {
  final String provider;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  const SocialAuthButton({
    super.key,
    required this.provider,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor, width: 1),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    AppSpacing.widthMd,
                  ],
                  Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Google sign-in button
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialAuthButton(
      provider: 'google',
      label: 'Continue with Google',
      backgroundColor: AppColors.white,
      textColor: AppColors.darkGray,
      borderColor: AppColors.lightGray,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/google_icon.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: SvgPicture.string(
          '''<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
            </svg>''',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}

/// Microsoft sign-in button
class MicrosoftSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const MicrosoftSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialAuthButton(
      provider: 'microsoft',
      label: 'Continue with Microsoft',
      backgroundColor: AppColors.white,
      textColor: AppColors.darkGray,
      borderColor: AppColors.lightGray,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: SvgPicture.string(
        '''<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M11.4 11.4H2V2h9.4v9.4z" fill="#F25022"/>
            <path d="M22 11.4h-9.4V2H22v9.4z" fill="#7FBA00"/>
            <path d="M11.4 22H2v-9.4h9.4V22z" fill="#00A4EF"/>
            <path d="M22 22h-9.4v-9.4H22V22z" fill="#FFB900"/>
          </svg>''',
        width: 24,
        height: 24,
      ),
    );
  }
}