import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// Authentication repository implementation
/// Implements the repository interface defined in domain layer
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // Perform remote login
      final tokenModel = await remoteDataSource.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      // Get user profile and permissions
      final userModel = await remoteDataSource.getCurrentUser();
      final permissions = await remoteDataSource.getUserPermissions();

      // Save to local storage
      await localDataSource.saveAuthData(
        token: tokenModel,
        user: userModel,
        permissions: permissions,
        rememberMe: rememberMe,
      );

      // Update last login time
      await localDataSource.updateLastLoginTime();

      return Right(tokenModel.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }



  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to logout remotely if connected
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.logout();
        } catch (e) {
          // Continue with local logout even if remote fails
        }
      }

      // Clear local data
      await localDataSource.clearAllAuthData();

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // Perform token refresh
      final tokenModel = await remoteDataSource.refreshToken(refreshToken);

      // Save new token
      await localDataSource.saveAuthToken(tokenModel);

      return Right(tokenModel.toEntity());
    } catch (e) {
      // If refresh fails, clear auth data
      await localDataSource.clearAllAuthData();
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get from local storage first
      final localUser = await localDataSource.getUserProfile();
      
      // If online and token is valid, try to get fresh data
      if (await networkInfo.isConnected) {
        try {
          final remoteUser = await remoteDataSource.getCurrentUser();
          
          // Update local cache
          await localDataSource.saveUserProfile(remoteUser);
          
          return Right(remoteUser.toEntity());
        } catch (e) {
          // If remote fails but we have local data, return local
          if (localUser != null) {
            return Right(localUser.toEntity());
          }
          return Left(ErrorHandler.handleException(e as Exception));
        }
      }

      // Return local data if available
      if (localUser != null) {
        return Right(localUser.toEntity());
      }

      return const Left(CacheFailure('No user data available'));
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      return await localDataSource.isLoggedIn();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      await remoteDataSource.forgotPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String token) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      await remoteDataSource.verifyEmail(token);
      
      // Update user profile if we have one locally
      final localUser = await localDataSource.getUserProfile();
      if (localUser != null) {
        final updatedUser = localUser.copyWith(isEmailVerified: true);
        await localDataSource.saveUserProfile(updatedUser);
      }

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> resendEmailVerification() async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      await remoteDataSource.resendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
  }) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final updatedUser = await remoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        avatar: avatar,
      );

      // Update local cache
      await localDataSource.saveUserProfile(updatedUser);

      return Right(updatedUser.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      // Check local token first
      final localToken = await localDataSource.getAuthToken();
      if (localToken == null) {
        return const Right(false);
      }

      // If token is expired, try to refresh
      if (localToken.isAccessTokenExpired) {
        if (localToken.isRefreshTokenExpired) {
          // Both tokens expired, user needs to login again
          await localDataSource.clearAllAuthData();
          return const Right(false);
        }

        // Try to refresh token
        final refreshResult = await refreshToken(localToken.refreshToken);
        return refreshResult.fold(
          (failure) => const Right(false),
          (newToken) => const Right(true),
        );
      }

      // Token is valid, check with server if online
      if (await networkInfo.isConnected) {
        try {
          final isValid = await remoteDataSource.validateToken(localToken.accessToken);
          if (!isValid) {
            await localDataSource.clearAllAuthData();
            return const Right(false);
          }
        } catch (e) {
          // If validation fails, assume offline but token is valid locally
        }
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, AuthToken?>> getStoredToken() async {
    try {
      final tokenModel = await localDataSource.getAuthToken();
      return Right(tokenModel?.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> clearAuthData() async {
    try {
      await localDataSource.clearAllAuthData();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, bool>> validateToken(String token) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final isValid = await remoteDataSource.validateToken(token);
      return Right(isValid);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserPermissions() async {
    try {
      // Try to get from local storage first
      final localPermissions = await localDataSource.getUserPermissions();
      
      // If online, try to get fresh permissions
      if (await networkInfo.isConnected) {
        try {
          final remotePermissions = await remoteDataSource.getUserPermissions();
          
          // Update local cache
          await localDataSource.saveUserPermissions(remotePermissions);
          
          return Right(remotePermissions);
        } catch (e) {
          // If remote fails but we have local data, return local
          if (localPermissions.isNotEmpty) {
            return Right(localPermissions);
          }
          return Left(ErrorHandler.handleException(e as Exception));
        }
      }

      return Right(localPermissions);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPermission(String permission) async {
    try {
      final permissionsResult = await getUserPermissions();
      return permissionsResult.fold(
        (failure) => Left(failure),
        (permissions) => Right(permissions.contains(permission)),
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      // Check network connection
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // Perform remote registration
      final tokenModel = await remoteDataSource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );

      // Get user profile and permissions
      final userModel = await remoteDataSource.getCurrentUser();
      final permissions = await remoteDataSource.getUserPermissions();

      // Save to local storage
      await localDataSource.saveAuthData(
        token: tokenModel,
        user: userModel,
        permissions: permissions,
        rememberMe: false, // Default to false for new registrations
      );

      // Update last login time
      await localDataSource.updateLastLoginTime();

      return Right(tokenModel.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }
}