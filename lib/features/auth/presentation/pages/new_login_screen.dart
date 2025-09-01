import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/validators.dart';
import '../../../../presentation/widgets/common/modern_text_field.dart';
import '../../../../presentation/widgets/auth/social_auth_button.dart';
import '../../../../presentation/screens/modules/module_dashboard.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _animationController;
  late AnimationController _logoAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScaleAnimation;
  
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _logoAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleEmailLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEmailLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleGoogleLogin() {
    context.read<AuthBloc>().add(const AuthGoogleLoginRequested());
  }

  void _handleMicrosoftLogin() {
    context.read<AuthBloc>().add(const AuthMicrosoftLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to dashboard based on user role
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ModuleDashboard(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutCubic,
                      )),
                      child: child,
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryMint.withOpacity(0.05),
                AppColors.white,
                AppColors.mintLight.withOpacity(0.3),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Logo and Header
                      _buildHeader(),
                      const SizedBox(height: 40),
                      // Authentication Card
                      _buildAuthenticationCard(),
                      const SizedBox(height: 24),
                      // Terms and Privacy
                      _buildFooterLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ScaleTransition(
          scale: _logoScaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryMint.withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 56,
              color: AppColors.primaryNavy,
            ),
          ),
        ),
        AppSpacing.heightXxl,
        Text(
          'Welcome Back',
          style: AppTextStyles.h1.copyWith(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.heightSm,
        Text(
          'Sign in to access your School Management portal',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAuthenticationCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Social Authentication Buttons
          _buildSocialAuthButtons(),
          
          AppSpacing.heightXl,
          
          // Divider
          _buildDivider(),
          
          AppSpacing.heightXl,
          
          // Email/Password Form
          _buildEmailPasswordForm(),
        ],
      ),
    );
  }

  Widget _buildSocialAuthButtons() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoginInProgress;
        final isGoogleLoading = isLoading && state.provider == 'google';
        final isMicrosoftLoading = isLoading && state.provider == 'microsoft';
        
        return Column(
          children: [
            GoogleSignInButton(
              onPressed: isLoading ? null : _handleGoogleLogin,
              isLoading: isGoogleLoading,
            ),
            AppSpacing.heightMd,
            MicrosoftSignInButton(
              onPressed: isLoading ? null : _handleMicrosoftLogin,
              isLoading: isMicrosoftLoading,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.lightGray,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with email',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkGray,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.lightGray,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailPasswordForm() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoginInProgress;
        final isEmailLoading = isLoading && state.provider == 'email';
        
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field
              ModernTextField(
                label: 'Email Address',
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: !isLoading,
              ),
              
              AppSpacing.heightLg,
              
              // Password Field
              ModernTextField(
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                controller: _passwordController,
                validator: (value) => Validators.validateRequired(
                  value,
                  fieldName: 'Password',
                ),
                obscureText: !_isPasswordVisible,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => isLoading ? null : _handleEmailLogin(),
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.darkGray,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              
              AppSpacing.heightMd,
              
              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: isLoading ? null : (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: AppColors.primaryMint,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      AppSpacing.widthSm,
                      Text(
                        'Remember me',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.darkGray,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: isLoading ? null : () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              AppSpacing.heightXl,
              
              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryMint,
                    foregroundColor: AppColors.primaryNavy,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading ? null : _handleEmailLogin,
                  child: isEmailLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryNavy,
                                ),
                              ),
                            ),
                            AppSpacing.widthMd,
                            Text(
                              'Signing In...',
                              style: AppTextStyles.buttonLarge.copyWith(
                                color: AppColors.primaryNavy,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Sign In',
                          style: AppTextStyles.buttonLarge.copyWith(
                            color: AppColors.primaryNavy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        Text(
          'By continuing, you agree to our',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.darkGray,
          ),
        ),
        AppSpacing.heightSm,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Handle terms
              },
              child: Text(
                'Terms of Service',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              ' and ',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.darkGray,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle privacy
              },
              child: Text(
                'Privacy Policy',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}