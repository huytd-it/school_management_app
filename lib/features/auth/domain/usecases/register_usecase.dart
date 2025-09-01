import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/validation_constants.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Register use case
/// Handles new user registration with validation
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(RegisterParams params) async {
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
    final errors = <String, String>{};

    // First name validation
    if (params.firstName.isEmpty) {
      errors['firstName'] = ValidationConstants.firstNameRequiredMessage;
    } else if (params.firstName.length < ValidationConstants.nameMinLength) {
      errors['firstName'] = ValidationConstants.getMinLengthMessage(ValidationConstants.nameMinLength);
    } else if (params.firstName.length > ValidationConstants.nameMaxLength) {
      errors['firstName'] = ValidationConstants.getMaxLengthMessage(ValidationConstants.nameMaxLength);
    } else if (!RegExp(ValidationConstants.namePattern).hasMatch(params.firstName)) {
      errors['firstName'] = ValidationConstants.nameErrorMessage;
    }

    // Last name validation
    if (params.lastName.isEmpty) {
      errors['lastName'] = ValidationConstants.lastNameRequiredMessage;
    } else if (params.lastName.length < ValidationConstants.nameMinLength) {
      errors['lastName'] = ValidationConstants.getMinLengthMessage(ValidationConstants.nameMinLength);
    } else if (params.lastName.length > ValidationConstants.nameMaxLength) {
      errors['lastName'] = ValidationConstants.getMaxLengthMessage(ValidationConstants.nameMaxLength);
    } else if (!RegExp(ValidationConstants.namePattern).hasMatch(params.lastName)) {
      errors['lastName'] = ValidationConstants.nameErrorMessage;
    }

    // Email validation
    if (params.email.isEmpty) {
      errors['email'] = ValidationConstants.emailRequiredMessage;
    } else if (!RegExp(ValidationConstants.emailPattern).hasMatch(params.email)) {
      errors['email'] = ValidationConstants.emailErrorMessage;
    }

    // Password validation
    if (params.password.isEmpty) {
      errors['password'] = ValidationConstants.passwordRequiredMessage;
    } else if (params.password.length < ValidationConstants.passwordMinLength) {
      errors['password'] = ValidationConstants.getMinLengthMessage(ValidationConstants.passwordMinLength);
    } else if (params.password.length > ValidationConstants.passwordMaxLength) {
      errors['password'] = ValidationConstants.getMaxLengthMessage(ValidationConstants.passwordMaxLength);
    } else if (!RegExp(ValidationConstants.passwordPattern).hasMatch(params.password)) {
      errors['password'] = ValidationConstants.passwordErrorMessage;
    }

    // Confirm password validation
    if (params.confirmPassword.isEmpty) {
      errors['confirmPassword'] = 'Please confirm your password';
    } else if (params.password != params.confirmPassword) {
      errors['confirmPassword'] = ValidationConstants.passwordMismatchMessage;
    }

    // Phone validation (optional)
    if (params.phone != null && params.phone!.isNotEmpty) {
      if (params.phone!.length < ValidationConstants.phoneMinLength ||
          params.phone!.length > ValidationConstants.phoneMaxLength) {
        errors['phone'] = 'Phone number must be between ${ValidationConstants.phoneMinLength} and ${ValidationConstants.phoneMaxLength} digits';
      } else if (!RegExp(ValidationConstants.phonePattern).hasMatch(params.phone!)) {
        errors['phone'] = ValidationConstants.phoneErrorMessage;
      }
    }

    // Return validation failure if there are errors
    if (errors.isNotEmpty) {
      return ValidationFailure(
        'Please fix the following errors:',
        errors,
      );
    }

    return null;
  }
}

/// Register parameters
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