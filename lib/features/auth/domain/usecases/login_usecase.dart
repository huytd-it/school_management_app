import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

/// Login use case
/// Handles user authentication with email and password
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(LoginParams params) async {
    // Validate input parameters
    final validationResult = _validateParams(params);
    if (validationResult != null) {
      return Left(validationResult);
    }

    // Perform login
    return await repository.login(
      email: params.email,
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }

  /// Validate login parameters
  Failure? _validateParams(LoginParams params) {
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

    if (params.password.length < 6) {
      return const ValidationFailure('Password must be at least 6 characters');
    }

    return null;
  }

  /// Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}

/// Login parameters
class LoginParams {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginParams({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  String toString() => 'LoginParams(email: $email, rememberMe: $rememberMe)';
}