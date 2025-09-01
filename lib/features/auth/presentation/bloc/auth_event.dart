import 'package:equatable/equatable.dart';

/// Base class for all authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check the current authentication status
class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();
}

/// Event triggered when user requests login with email/password
class AuthEmailLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Event triggered when user requests Google login
class AuthGoogleLoginRequested extends AuthEvent {
  const AuthGoogleLoginRequested();
}

/// Event triggered when user requests Microsoft login
class AuthMicrosoftLoginRequested extends AuthEvent {
  const AuthMicrosoftLoginRequested();
}

/// Event triggered when user requests logout
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Event triggered to refresh authentication tokens
class AuthTokenRefreshRequested extends AuthEvent {
  const AuthTokenRefreshRequested();
}

/// Event triggered when authentication state changes externally
class AuthStateChanged extends AuthEvent {
  final bool isAuthenticated;
  
  const AuthStateChanged(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}

/// Event triggered when user requests registration
class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String? phone;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword, firstName, lastName, phone];
}

/// Event triggered when user requests password reset
class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Event triggered when user submits new password during reset
class AuthResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;
  final String confirmPassword;

  const AuthResetPasswordRequested({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [token, newPassword, confirmPassword];
}

/// Event triggered when user requests password change
class AuthChangePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const AuthChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}

/// Event triggered when user requests email verification
class AuthEmailVerificationRequested extends AuthEvent {
  final String token;

  const AuthEmailVerificationRequested({required this.token});

  @override
  List<Object?> get props => [token];
}

/// Event triggered when user requests to resend email verification
class AuthEmailVerificationResendRequested extends AuthEvent {
  const AuthEmailVerificationResendRequested();
}

/// Event triggered when user requests to update profile information
class AuthProfileUpdateRequested extends AuthEvent {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatar;

  const AuthProfileUpdateRequested({
    this.firstName,
    this.lastName,
    this.phone,
    this.avatar,
  });

  @override
  List<Object?> get props => [firstName, lastName, phone, avatar];
}

/// Event triggered to clear any authentication errors
class AuthErrorCleared extends AuthEvent {
  const AuthErrorCleared();
}

/// Event triggered for auto-login functionality (e.g., when user has opted to "remember me")
class AuthAutoLoginRequested extends AuthEvent {
  const AuthAutoLoginRequested();
}

/// Event triggered when session timeout is detected
class AuthSessionTimeoutDetected extends AuthEvent {
  const AuthSessionTimeoutDetected();
}