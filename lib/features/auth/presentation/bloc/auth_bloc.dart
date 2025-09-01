import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/password_usecases.dart';
import '../../domain/usecases/user_usecases.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Authentication BLoC
/// Manages authentication state throughout the application
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.refreshTokenUseCase,
    required this.getCurrentUserUseCase,
    required this.checkAuthStatusUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.changePasswordUseCase,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    // Register event handlers
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
    on<AuthTokenRefreshRequested>(_onTokenRefreshRequested);
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthChangePasswordRequested>(_onChangePasswordRequested);
    on<AuthEmailVerificationRequested>(_onEmailVerificationRequested);
    on<AuthEmailVerificationResendRequested>(_onEmailVerificationResendRequested);
    on<AuthProfileUpdateRequested>(_onProfileUpdateRequested);
    on<AuthErrorCleared>(_onErrorCleared);
    on<AuthAutoLoginRequested>(_onAutoLoginRequested);
    on<AuthSessionTimeoutDetected>(_onSessionTimeoutDetected);
  }

  /// Handle login request
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Signing in...'));

    final result = await loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
      rememberMe: event.rememberMe,
    ));

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (token) async {
        // Get user profile and permissions
        final userResult = await getCurrentUserUseCase();
        final permissionsResult = await authRepository.getUserPermissions();

        userResult.fold(
          (failure) => emit(_mapFailureToErrorState(failure)),
          (user) {
            permissionsResult.fold(
              (failure) => emit(AuthAuthenticated(user: user, permissions: [])),
              (permissions) => emit(AuthAuthenticated(user: user, permissions: permissions)),
            );
          },
        );
      },
    );
  }

  /// Handle register request
  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Creating account...'));

    final result = await registerUseCase(RegisterParams(
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
    ));

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (user) => emit(AuthRegistrationSuccess(
        user: user,
        message: 'Account created successfully! Please verify your email.',
      )),
    );
  }

  /// Handle logout request
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Signing out...'));

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthLogoutSuccess(message: 'Signed out successfully')),
    );
  }

  /// Handle authentication status check
  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStatusChecking());

    final result = await checkAuthStatusUseCase();

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (isAuthenticated) async {
        if (isAuthenticated) {
          // Get user profile and permissions
          final userResult = await getCurrentUserUseCase();
          final permissionsResult = await authRepository.getUserPermissions();

          userResult.fold(
            (failure) => emit(const AuthUnauthenticated()),
            (user) {
              permissionsResult.fold(
                (failure) => emit(AuthAuthenticated(user: user, permissions: [])),
                (permissions) => emit(AuthAuthenticated(user: user, permissions: permissions)),
              );
            },
          );
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Handle token refresh request
  Future<void> _onTokenRefreshRequested(
    AuthTokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    final tokenResult = await authRepository.getStoredToken();
    
    tokenResult.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (token) async {
        if (token != null) {
          final refreshResult = await refreshTokenUseCase(token.refreshToken);
          
          refreshResult.fold(
            (failure) => emit(const AuthUnauthenticated()),
            (newToken) async {
              final userResult = await getCurrentUserUseCase();
              
              userResult.fold(
                (failure) => emit(const AuthUnauthenticated()),
                (user) => emit(AuthTokenRefreshSuccess(user: user)),
              );
            },
          );
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Handle forgot password request
  Future<void> _onForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Sending password reset email...'));

    final result = await forgotPasswordUseCase(event.email);

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthPasswordResetEmailSent(
        message: 'Password reset email sent! Please check your inbox.',
      )),
    );
  }

  /// Handle reset password request
  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Resetting password...'));

    final result = await resetPasswordUseCase(ResetPasswordParams(
      token: event.token,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthPasswordResetSuccess(
        message: 'Password reset successfully! You can now login with your new password.',
      )),
    );
  }

  /// Handle change password request
  Future<void> _onChangePasswordRequested(
    AuthChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Changing password...'));

    final result = await changePasswordUseCase(ChangePasswordParams(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthPasswordChangeSuccess(
        message: 'Password changed successfully!',
      )),
    );
  }

  /// Handle email verification request
  Future<void> _onEmailVerificationRequested(
    AuthEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Verifying email...'));

    final result = await authRepository.verifyEmail(event.token);

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthEmailVerificationSuccess(
        message: 'Email verified successfully!',
      )),
    );
  }

  /// Handle resend email verification request
  Future<void> _onEmailVerificationResendRequested(
    AuthEmailVerificationResendRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Resending verification email...'));

    final result = await authRepository.resendEmailVerification();

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (_) => emit(const AuthEmailVerificationResent(
        message: 'Verification email sent! Please check your inbox.',
      )),
    );
  }

  /// Handle profile update request
  Future<void> _onProfileUpdateRequested(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(message: 'Updating profile...'));

    final result = await authRepository.updateProfile(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      avatar: event.avatar,
    );

    result.fold(
      (failure) => emit(_mapFailureToErrorState(failure)),
      (user) => emit(AuthProfileUpdateSuccess(
        user: user,
        message: 'Profile updated successfully!',
      )),
    );
  }

  /// Handle error cleared
  void _onErrorCleared(
    AuthErrorCleared event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle auto login request
  Future<void> _onAutoLoginRequested(
    AuthAutoLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStatusChecking());

    // Check if user has valid stored credentials
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      add(const AuthStatusChecked());
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle session timeout
  Future<void> _onSessionTimeoutDetected(
    AuthSessionTimeoutDetected event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.clearAuthData();
    emit(const AuthSessionExpired(
      message: 'Your session has expired. Please login again.',
    ));
  }

  /// Map failure to error state
  AuthError _mapFailureToErrorState(Failure failure) {
    if (failure is ValidationFailure) {
      return AuthError(
        message: failure.message,
        code: failure.code,
        validationErrors: failure.errors,
      );
    } else if (failure is NetworkFailure) {
      return AuthError(
        message: failure.message,
        code: failure.code,
      );
    } else if (failure is AuthFailure) {
      return AuthError(
        message: failure.message,
        code: failure.code,
      );
    } else if (failure is ServerFailure) {
      return AuthError(
        message: failure.message,
        code: failure.code,
      );
    } else {
      return AuthError(
        message: failure.message,
        code: failure.code,
      );
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => state is AuthAuthenticated;

  /// Get current user
  User? get currentUser {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      return currentState.user;
    }
    return null;
  }

  /// Get user permissions
  List<String> get userPermissions {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      return currentState.permissions;
    }
    return [];
  }

  /// Check if user has permission
  bool hasPermission(String permission) {
    return userPermissions.contains(permission);
  }

  /// Check if user has any of the permissions
  bool hasAnyPermission(List<String> permissions) {
    return permissions.any((permission) => userPermissions.contains(permission));
  }

  /// Check if user has all permissions
  bool hasAllPermissions(List<String> permissions) {
    return permissions.every((permission) => userPermissions.contains(permission));
  }
}