import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../widgets/common/modern_text_field.dart';
import '../dashboard/admin_dashboard.dart';
import '../dashboard/teacher_dashboard.dart';
import '../dashboard/student_dashboard.dart';
import '../dashboard/parent_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // For demo purposes, navigate based on email domain
        final email = _emailController.text.toLowerCase();
        Widget destinationScreen;

        if (email.contains('admin')) {
          destinationScreen = const AdminDashboard();
        } else if (email.contains('teacher')) {
          destinationScreen = const TeacherDashboard();
        } else if (email.contains('student')) {
          destinationScreen = const StudentDashboard();
        } else if (email.contains('parent')) {
          destinationScreen = const ParentDashboard();
        } else {
          // Default to student dashboard
          destinationScreen = const StudentDashboard();
        }

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                destinationScreen,
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryMint.withOpacity(0.1),
              AppColors.white,
              AppColors.mintLight,
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
                    const SizedBox(height: 40),
                    // Logo and Welcome Text
                    _buildHeader(),
                    const SizedBox(height: 48),
                    // Login Form
                    _buildLoginForm(),
                    const SizedBox(height: 24),
                    // Forgot Password
                    _buildForgotPassword(),
                    const SizedBox(height: 40),
                    // Demo Hint
                    _buildDemoHint(),
                  ],
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryMint.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 48,
            color: AppColors.primaryNavy,
          ),
        ),
        AppSpacing.heightXxl,
        Text(
          'Welcome Back',
          style: AppTextStyles.h1,
        ),
        AppSpacing.heightSm,
        Text(
          'Sign in to continue to SchoolApp',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppDecorations.softCard,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ModernTextField(
              label: 'Email or Username',
              hint: 'Enter your email',
              prefixIcon: Icons.person_outline_rounded,
              controller: _emailController,
              validator: Validators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            AppSpacing.heightXl,
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
              onFieldSubmitted: (_) => _handleLogin(),
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
            AppSpacing.heightXxl,
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: AppDecorations.primaryButtonStyle,
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryNavy,
                          ),
                        ),
                      )
                    : Text(
                        'Sign In',
                        style: AppTextStyles.buttonLarge.copyWith(
                          color: AppColors.primaryNavy,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // Handle forgot password
      },
      child: Text(
        'Forgot Password?',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.primaryNavy,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDemoHint() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.info.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: AppColors.info,
              ),
              AppSpacing.widthSm,
              Text(
                'Demo Credentials',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          AppSpacing.heightMd,
          Text(
            'Use email containing role keywords:\n'
            '• admin@school.com → Admin Dashboard\n'
            '• teacher@school.com → Teacher Dashboard\n'
            '• student@school.com → Student Dashboard\n'
            '• parent@school.com → Parent Dashboard',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.info,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}