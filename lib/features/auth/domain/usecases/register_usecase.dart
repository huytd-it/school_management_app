import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/validation_constants.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

/// Register use case
/// Handles user registration with email, password and personal details
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(RegisterParams params) async {
    // Validate input parameters
    final validationResult = _validateParams(params);
    if (validationResult != null) {
      return Left(validationResult);
    }

    // Perform registration
    return await repository.register(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
    );
  }

  /// Validate registration parameters
  Failure? _validateParams(RegisterParams params) {
    // Email validation
    if (params.email.isEmpty) {
      return const ValidationFailure('Email is required');
    }

    if (!_isValidEmail(params.email)) {
      return const ValidationFailure('Please enter a valid email address');
    }

    // Password validation
    if (params.password.isEmpty) {
      return const ValidationFailure('Password is required');
    }

    if (params.password.length < ValidationConstants.passwordMinLength) {
      return ValidationFailure(
        ValidationConstants.getMinLengthMessage(ValidationConstants.passwordMinLength),
      );
    }

    if (params.password.length > ValidationConstants.passwordMaxLength) {
      return ValidationFailure(
        ValidationConstants.getMaxLengthMessage(ValidationConstants.passwordMaxLength),
      );
    }

    if (!RegExp(ValidationConstants.passwordPattern).hasMatch(params.password)) {
      return const ValidationFailure(ValidationConstants.passwordErrorMessage);
    }

    // Confirm password validation
    if (params.confirmPassword.isEmpty) {
      return const ValidationFailure('Please confirm your password');
    }

    if (params.password != params.confirmPassword) {
      return const ValidationFailure(ValidationConstants.passwordMismatchMessage);
    }

    // First name validation
    if (params.firstName.isEmpty) {
      return const ValidationFailure('First name is required');
    }

    if (params.firstName.length < ValidationConstants.nameMinLength) {
      return ValidationFailure(
        ValidationConstants.getMinLengthMessage(ValidationConstants.nameMinLength),
      );
    }

    if (params.firstName.length > ValidationConstants.nameMaxLength) {
      return ValidationFailure(
        ValidationConstants.getMaxLengthMessage(ValidationConstants.nameMaxLength),
      );
    }

    if (!RegExp(ValidationConstants.namePattern).hasMatch(params.firstName)) {
      return const ValidationFailure('First name contains invalid characters');
    }

    // Last name validation
    if (params.lastName.isEmpty) {
      return const ValidationFailure('Last name is required');
    }

    if (params.lastName.length < ValidationConstants.nameMinLength) {
      return ValidationFailure(
        ValidationConstants.getMinLengthMessage(ValidationConstants.nameMinLength),
      );
    }

    if (params.lastName.length > ValidationConstants.nameMaxLength) {
      return ValidationFailure(
        ValidationConstants.getMaxLengthMessage(ValidationConstants.nameMaxLength),
      );
    }

    if (!RegExp(ValidationConstants.namePattern).hasMatch(params.lastName)) {
      return const ValidationFailure('Last name contains invalid characters');
    }

    // Phone validation (optional)
    if (params.phone != null && params.phone!.isNotEmpty) {
      if (!RegExp(ValidationConstants.phonePattern).hasMatch(params.phone!)) {
        return const ValidationFailure('Please enter a valid phone number');
      }
    }

    return null;
  }

  /// Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(ValidationConstants.emailPattern).hasMatch(email);
  }
}

/// Registration parameters
class RegisterParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String? phone;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    this.phone,
  });

  @override
  String toString() => 'RegisterParams(email: $email, firstName: $firstName, lastName: $lastName)';
}