import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../entities/auth_token.dart';

/// Authentication repository interface
/// Defines contracts for authentication data operations
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Refresh authentication token
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken);

  /// Get current user profile
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Forgot password
  Future<Either<Failure, void>> forgotPassword(String email);

  /// Reset password
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Verify email
  Future<Either<Failure, void>> verifyEmail(String token);

  /// Resend email verification
  Future<Either<Failure, void>> resendEmailVerification();

  /// Change password
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
  });

  /// Check authentication status
  Future<Either<Failure, bool>> checkAuthStatus();

  /// Get stored authentication token
  Future<Either<Failure, AuthToken?>> getStoredToken();

  /// Clear authentication data
  Future<Either<Failure, void>> clearAuthData();

  /// Validate token
  Future<Either<Failure, bool>> validateToken(String token);

  /// Get user permissions
  Future<Either<Failure, List<String>>> getUserPermissions();

  /// Check if user has permission
  Future<Either<Failure, bool>> hasPermission(String permission);

  /// Register new user
  Future<Either<Failure, AuthToken>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  });
}