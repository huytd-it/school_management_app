import 'package:equatable/equatable.dart';
import '../../../../core/services/auth_models.dart';

/// Base class for all authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app starts
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when checking authentication status
class AuthLoading extends AuthState {
  final String? message;
  
  const AuthLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// State when user is authenticated
class AuthAuthenticated extends AuthState {
  final AuthUser user;
  
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// State when user is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State when authentication process fails
class AuthError extends AuthState {
  final String message;
  final String? errorCode;
  
  const AuthError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

/// State when login is in progress
class AuthLoginInProgress extends AuthState {
  final String provider;
  
  const AuthLoginInProgress(this.provider);

  @override
  List<Object?> get props => [provider];
}

/// State when logout is in progress
class AuthLogoutInProgress extends AuthState {
  const AuthLogoutInProgress();
}

/// State when token refresh is in progress
class AuthTokenRefreshing extends AuthState {
  const AuthTokenRefreshing();
}

/// Registration success state
class AuthRegistrationSuccess extends AuthState {
  final AuthUser user;
  final String message;

  const AuthRegistrationSuccess({
    required this.user,
    required this.message,
  });

  @override
  List<Object?> get props => [user, message];
}

/// Password reset email sent state
class AuthPasswordResetEmailSent extends AuthState {
  final String message;

  const AuthPasswordResetEmailSent({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Password reset success state
class AuthPasswordResetSuccess extends AuthState {
  final String message;

  const AuthPasswordResetSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Password change success state
class AuthPasswordChangeSuccess extends AuthState {
  final String message;

  const AuthPasswordChangeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Email verification success state
class AuthEmailVerificationSuccess extends AuthState {
  final String message;

  const AuthEmailVerificationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Email verification resent state
class AuthEmailVerificationResent extends AuthState {
  final String message;

  const AuthEmailVerificationResent({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Profile update success state
class AuthProfileUpdateSuccess extends AuthState {
  final AuthUser user;
  final String message;

  const AuthProfileUpdateSuccess({
    required this.user,
    required this.message,
  });

  @override
  List<Object?> get props => [user, message];
}

/// Session expired state
class AuthSessionExpired extends AuthState {
  final String message;

  const AuthSessionExpired({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Token refresh success state
class AuthTokenRefreshSuccess extends AuthState {
  final AuthUser user;

  const AuthTokenRefreshSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Logout success state
class AuthLogoutSuccess extends AuthState {
  final String message;

  const AuthLogoutSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Checking authentication status state
class AuthStatusChecking extends AuthState {
  const AuthStatusChecking();
}