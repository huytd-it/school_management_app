import 'package:equatable/equatable.dart';

/// Base authentication event
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Login event
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

/// Register event
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

/// Logout event
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Check authentication status event
class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();
}

/// Refresh token event
class AuthTokenRefreshRequested extends AuthEvent {
  const AuthTokenRefreshRequested();
}

/// Forgot password event
class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Reset password event
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

/// Change password event
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

/// Verify email event
class AuthEmailVerificationRequested extends AuthEvent {
  final String token;

  const AuthEmailVerificationRequested({required this.token});

  @override
  List<Object?> get props => [token];
}

/// Resend email verification event
class AuthEmailVerificationResendRequested extends AuthEvent {
  const AuthEmailVerificationResendRequested();
}

/// Update profile event
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

/// Clear error event
class AuthErrorCleared extends AuthEvent {
  const AuthErrorCleared();
}

/// Auto login event (for remember me functionality)
class AuthAutoLoginRequested extends AuthEvent {
  const AuthAutoLoginRequested();
}

/// Session timeout event
class AuthSessionTimeoutDetected extends AuthEvent {
  const AuthSessionTimeoutDetected();
}