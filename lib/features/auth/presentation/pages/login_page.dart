import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/injection_container.dart';
import '../../../shared/widgets/common/app_button.dart';
import '../../../shared/widgets/common/app_text_field.dart';
import '../../../shared/widgets/common/app_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Login page for user authentication
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.lightGray,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              // Navigate to dashboard
              Navigator.of(context).pushReplacementNamed(
                state.user.dashboardRoute,
              );
            } else if (state is AuthError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _buildLoginForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return AppCard(
      padding: const EdgeInsets.all(AppDimensions.xl),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.xl),
            _buildEmailField(),
            const SizedBox(height: AppDimensions.md),
            _buildPasswordField(),
            const SizedBox(height: AppDimensions.md),
            _buildRememberMeRow(),
            const SizedBox(height: AppDimensions.xl),
            _buildLoginButton(),
            const SizedBox(height: AppDimensions.md),
            _buildForgotPasswordLink(),
            const SizedBox(height: AppDimensions.lg),
            _buildRegisterLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryMint,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          child: const Icon(
            Icons.school,
            size: 40,
            color: AppColors.primaryNavy,
          ),
        ),
        const SizedBox(height: AppDimensions.md),
        Text(
          'Welcome Back',
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.xs),
        Text(
          'Sign in to your account',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return AppTextField.email(
      label: 'Email Address',
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return AppTextField.password(
      label: 'Password',
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
          activeColor: AppColors.primaryMint,
        ),
        const SizedBox(width: AppDimensions.xs),
        Text(
          'Remember me',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        
        return AppButton.primary(
          text: 'Sign In',
          onPressed: isLoading ? null : _handleLogin,
          isLoading: isLoading,
          isFullWidth: true,
        );
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/forgot-password');
        },
        child: Text(
          'Forgot your password?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\\'t have an account? ',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkGray,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/register');
          },
          child: Text(
            'Sign up',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          rememberMe: _rememberMe,
        ),
      );
    }
  }
}"