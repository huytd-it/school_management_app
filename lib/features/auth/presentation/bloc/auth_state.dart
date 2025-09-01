import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Base authentication state
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state
class AuthLoading extends AuthState {
  final String? message;

  const AuthLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Authenticated state
class AuthAuthenticated extends AuthState {
  final User user;
  final List<String> permissions;

  const AuthAuthenticated({
    required this.user,
    required this.permissions,
  });

  @override
  List<Object?> get props => [user, permissions];
}

/// Unauthenticated state
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Authentication error state
class AuthError extends AuthState {
  final String message;
  final String? code;
  final Map<String, String>? validationErrors;

  const AuthError({
    required this.message,
    this.code,
    this.validationErrors,
  });

  @override
  List<Object?> get props => [message, code, validationErrors];

  /// Check if this is a validation error
  bool get isValidationError => validationErrors != null && validationErrors!.isNotEmpty;

  /// Check if this is a network error
  bool get isNetworkError => code == 'NO_INTERNET' || code == 'TIMEOUT_ERROR';

  /// Check if this is an authentication error
  bool get isAuthError => code == 'UNAUTHORIZED' || code == 'FORBIDDEN';
}

/// Registration success state
class AuthRegistrationSuccess extends AuthState {
  final User user;
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
  final User user;
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
  final User user;

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