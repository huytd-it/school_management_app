import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// Remote data source for authentication operations
/// Handles API calls for authentication
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<AuthTokenModel> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  /// Register new user
  Future<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  });

  /// Logout current user
  Future<void> logout();

  /// Refresh authentication token
  Future<AuthTokenModel> refreshToken(String refreshToken);

  /// Get current user profile
  Future<UserModel> getCurrentUser();

  /// Forgot password
  Future<void> forgotPassword(String email);

  /// Reset password
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Verify email
  Future<void> verifyEmail(String token);

  /// Resend email verification
  Future<void> resendEmailVerification();

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Update user profile
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
  });

  /// Validate token
  Future<bool> validateToken(String token);

  /// Get user permissions
  Future<List<String>> getUserPermissions();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthTokenModel> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
          'remember_me': rememberMe,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return AuthTokenModel.fromApiResponse(data);
      } else {
        throw ServerException(
          'Login failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Invalid email or password');
      } else if (e.response?.statusCode == 422) {
        final data = e.response?.data as Map<String, dynamic>?;
        final message = data?['message'] ?? 'Validation failed';
        throw ValidationException(message);
      }
      throw ServerException(e.message ?? 'Login failed');
    } catch (e) {
      throw ServerException('Unexpected error during login: $e');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          if (phone != null) 'phone': phone,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        return UserModel.fromJson(data['user'] ?? data);
      } else {
        throw ServerException(
          'Registration failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final data = e.response?.data as Map<String, dynamic>?;
        final message = data?['message'] ?? 'Validation failed';
        final errors = data?['errors'] as Map<String, dynamic>?;
        throw ValidationException(message, errors?.cast<String, String>());
      }
      throw ServerException(e.message ?? 'Registration failed');
    } catch (e) {
      throw ServerException('Unexpected error during registration: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await apiClient.post(ApiConstants.logout);

      if (response.statusCode != 200) {
        throw ServerException(
          'Logout failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      // Even if logout fails on server, we should clear local data
      throw ServerException(e.message ?? 'Logout failed');
    } catch (e) {
      throw ServerException('Unexpected error during logout: $e');
    }
  }

  @override
  Future<AuthTokenModel> refreshToken(String refreshToken) async {
    try {
      final response = await apiClient.post(
        ApiConstants.refreshToken,
        data: {
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return AuthTokenModel.fromApiResponse(data);
      } else {
        throw ServerException(
          'Token refresh failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Refresh token expired or invalid');
      }
      throw ServerException(e.message ?? 'Token refresh failed');
    } catch (e) {
      throw ServerException('Unexpected error during token refresh: $e');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await apiClient.get(ApiConstants.profile);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return UserModel.fromJson(data);
      } else {
        throw ServerException(
          'Failed to get user profile with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('User not authenticated');
      }
      throw ServerException(e.message ?? 'Failed to get user profile');
    } catch (e) {
      throw ServerException('Unexpected error getting user profile: $e');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response = await apiClient.post(
        ApiConstants.forgotPassword,
        data: {
          'email': email,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Forgot password failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Forgot password failed');
    } catch (e) {
      throw ServerException('Unexpected error during forgot password: $e');
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.resetPassword,
        data: {
          'token': token,
          'password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Password reset failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw const ValidationException('Invalid or expired reset token');
      }
      throw ServerException(e.message ?? 'Password reset failed');
    } catch (e) {
      throw ServerException('Unexpected error during password reset: $e');
    }
  }

  @override
  Future<void> verifyEmail(String token) async {
    try {
      final response = await apiClient.post(
        ApiConstants.verifyEmail,
        data: {
          'token': token,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Email verification failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw const ValidationException('Invalid or expired verification token');
      }
      throw ServerException(e.message ?? 'Email verification failed');
    } catch (e) {
      throw ServerException('Unexpected error during email verification: $e');
    }
  }

  @override
  Future<void> resendEmailVerification() async {
    try {
      final response = await apiClient.post(ApiConstants.resendVerification);

      if (response.statusCode != 200) {
        throw ServerException(
          'Resend verification failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Resend verification failed');
    } catch (e) {
      throw ServerException('Unexpected error during resend verification: $e');
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.changePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Password change failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw const ValidationException('Current password is incorrect');
      }
      throw ServerException(e.message ?? 'Password change failed');
    } catch (e) {
      throw ServerException('Unexpected error during password change: $e');
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (firstName != null) data['first_name'] = firstName;
      if (lastName != null) data['last_name'] = lastName;
      if (phone != null) data['phone'] = phone;
      if (avatar != null) data['avatar'] = avatar;

      final response = await apiClient.put(
        ApiConstants.updateProfile,
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return UserModel.fromJson(responseData);
      } else {
        throw ServerException(
          'Profile update failed with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final data = e.response?.data as Map<String, dynamic>?;
        final message = data?['message'] ?? 'Validation failed';
        final errors = data?['errors'] as Map<String, dynamic>?;
        throw ValidationException(message, errors?.cast<String, String>());
      }
      throw ServerException(e.message ?? 'Profile update failed');
    } catch (e) {
      throw ServerException('Unexpected error during profile update: $e');
    }
  }

  @override
  Future<bool> validateToken(String token) async {
    try {
      // Add token to authorization header
      final response = await apiClient.get(
        '/auth/validate',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getUserPermissions() async {
    try {
      final response = await apiClient.get('/user/permissions');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final permissions = data['permissions'] as List<dynamic>;
        return permissions.cast<String>();
      } else {
        throw ServerException(
          'Failed to get permissions with status code: ${response.statusCode}',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to get permissions');
    } catch (e) {
      throw ServerException('Unexpected error getting permissions: $e');
    }
  }
}