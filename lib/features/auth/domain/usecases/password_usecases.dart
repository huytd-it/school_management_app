import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/validation_constants.dart';
import '../repositories/auth_repository.dart';

/// Forgot password use case
/// Handles password reset request
class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    // Validate email
    if (email.isEmpty) {
      return const Left(ValidationFailure('Email is required'));
    }

    if (!RegExp(ValidationConstants.emailPattern).hasMatch(email)) {
      return const Left(ValidationFailure('Please enter a valid email address'));
    }

    // Send password reset email
    return await repository.forgotPassword(email);
  }
}

/// Reset password use case
/// Handles password reset with token
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    // Validate parameters
    final validationResult = _validateParams(params);
    if (validationResult != null) {
      return Left(validationResult);
    }

    // Reset password
    return await repository.resetPassword(
      token: params.token,
      newPassword: params.newPassword,
    );
  }

  /// Validate reset password parameters
  Failure? _validateParams(ResetPasswordParams params) {
    // Token validation
    if (params.token.isEmpty) {
      return const ValidationFailure('Reset token is required');
    }

    // New password validation
    if (params.newPassword.isEmpty) {
      return const ValidationFailure('New password is required');
    }

    if (params.newPassword.length < ValidationConstants.passwordMinLength) {
      return ValidationFailure(
        ValidationConstants.getMinLengthMessage(ValidationConstants.passwordMinLength),
      );
    }

    if (params.newPassword.length > ValidationConstants.passwordMaxLength) {
      return ValidationFailure(
        ValidationConstants.getMaxLengthMessage(ValidationConstants.passwordMaxLength),
      );
    }

    if (!RegExp(ValidationConstants.passwordPattern).hasMatch(params.newPassword)) {
      return const ValidationFailure(ValidationConstants.passwordErrorMessage);
    }

    // Confirm password validation
    if (params.confirmPassword.isEmpty) {
      return const ValidationFailure('Please confirm your new password');
    }

    if (params.newPassword != params.confirmPassword) {
      return const ValidationFailure(ValidationConstants.passwordMismatchMessage);
    }

    return null;
  }
}

/// Change password use case
/// Handles password change for authenticated users
class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    // Validate parameters
    final validationResult = _validateParams(params);
    if (validationResult != null) {
      return Left(validationResult);
    }

    // Change password
    return await repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }

  /// Validate change password parameters
  Failure? _validateParams(ChangePasswordParams params) {
    // Current password validation
    if (params.currentPassword.isEmpty) {
      return const ValidationFailure('Current password is required');
    }

    // New password validation
    if (params.newPassword.isEmpty) {
      return const ValidationFailure('New password is required');
    }

    if (params.newPassword.length < ValidationConstants.passwordMinLength) {
      return ValidationFailure(
        ValidationConstants.getMinLengthMessage(ValidationConstants.passwordMinLength),
      );
    }

    if (params.newPassword.length > ValidationConstants.passwordMaxLength) {
      return ValidationFailure(
        ValidationConstants.getMaxLengthMessage(ValidationConstants.passwordMaxLength),
      );
    }

    if (!RegExp(ValidationConstants.passwordPattern).hasMatch(params.newPassword)) {
      return const ValidationFailure(ValidationConstants.passwordErrorMessage);
    }

    // Check if new password is different from current
    if (params.currentPassword == params.newPassword) {
      return const ValidationFailure('New password must be different from current password');
    }

    // Confirm password validation
    if (params.confirmPassword.isEmpty) {
      return const ValidationFailure('Please confirm your new password');
    }

    if (params.newPassword != params.confirmPassword) {
      return const ValidationFailure(ValidationConstants.passwordMismatchMessage);
    }

    return null;
  }
}

/// Reset password parameters
class ResetPasswordParams {
  final String token;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordParams({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });
}

/// Change password parameters
class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}