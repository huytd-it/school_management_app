import '../../../../core/constants/storage_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// Local data source for authentication operations
/// Handles local storage of authentication data
abstract class AuthLocalDataSource {
  /// Save authentication token
  Future<void> saveAuthToken(AuthTokenModel token);

  /// Get stored authentication token
  Future<AuthTokenModel?> getAuthToken();

  /// Clear authentication token
  Future<void> clearAuthToken();

  /// Save user profile
  Future<void> saveUserProfile(UserModel user);

  /// Get stored user profile
  Future<UserModel?> getUserProfile();

  /// Clear user profile
  Future<void> clearUserProfile();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Save user permissions
  Future<void> saveUserPermissions(List<String> permissions);

  /// Get user permissions
  Future<List<String>> getUserPermissions();

  /// Clear user permissions
  Future<void> clearUserPermissions();

  /// Save remember me preference
  Future<void> saveRememberMe(bool rememberMe);

  /// Get remember me preference
  Future<bool> getRememberMe();

  /// Clear all authentication data
  Future<void> clearAllAuthData();

  /// Save authentication data from successful login
  Future<void> saveAuthData({
    required AuthTokenModel token,
    required UserModel user,
    required List<String> permissions,
    bool rememberMe = false,
  });

  /// Update last login time
  Future<void> updateLastLoginTime();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService storageService;

  AuthLocalDataSourceImpl({required this.storageService});

  @override
  Future<void> saveAuthToken(AuthTokenModel token) async {
    try {
      final tokenJson = token.toJson();
      await storageService.setObject(StorageConstants.keyAccessToken, tokenJson);
    } catch (e) {
      throw CacheException('Failed to save auth token: $e');
    }
  }

  @override
  Future<AuthTokenModel?> getAuthToken() async {
    try {
      final tokenJson = await storageService.getObject(StorageConstants.keyAccessToken);
      if (tokenJson == null) return null;
      
      return AuthTokenModel.fromJson(tokenJson);
    } catch (e) {
      throw CacheException('Failed to get auth token: $e');
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await storageService.remove(StorageConstants.keyAccessToken);
      await storageService.remove(StorageConstants.keyRefreshToken);
    } catch (e) {
      throw CacheException('Failed to clear auth token: $e');
    }
  }

  @override
  Future<void> saveUserProfile(UserModel user) async {
    try {
      final userJson = user.toJson();
      await storageService.setObject(StorageConstants.keyUserProfile, userJson);
      
      // Also save user role separately for quick access
      await storageService.setString(StorageConstants.keyUserRole, user.role.value);
    } catch (e) {
      throw CacheException('Failed to save user profile: $e');
    }
  }

  @override
  Future<UserModel?> getUserProfile() async {
    try {
      final userJson = await storageService.getObject(StorageConstants.keyUserProfile);
      if (userJson == null) return null;
      
      return UserModel.fromJson(userJson);
    } catch (e) {
      throw CacheException('Failed to get user profile: $e');
    }
  }

  @override
  Future<void> clearUserProfile() async {
    try {
      await storageService.remove(StorageConstants.keyUserProfile);
      await storageService.remove(StorageConstants.keyUserRole);
    } catch (e) {
      throw CacheException('Failed to clear user profile: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await getAuthToken();
      if (token == null) return false;
      
      // Check if token is not expired
      return !token.isAccessTokenExpired;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveUserPermissions(List<String> permissions) async {
    try {
      await storageService.setStringList(StorageConstants.keyUserPermissions, permissions);
    } catch (e) {
      throw CacheException('Failed to save user permissions: $e');
    }
  }

  @override
  Future<List<String>> getUserPermissions() async {
    try {
      final permissions = await storageService.getStringList(StorageConstants.keyUserPermissions);
      return permissions ?? [];
    } catch (e) {
      throw CacheException('Failed to get user permissions: $e');
    }
  }

  @override
  Future<void> clearUserPermissions() async {
    try {
      await storageService.remove(StorageConstants.keyUserPermissions);
    } catch (e) {
      throw CacheException('Failed to clear user permissions: $e');
    }
  }

  @override
  Future<void> saveRememberMe(bool rememberMe) async {
    try {
      await storageService.setBool(StorageConstants.keyRememberCredentials, rememberMe);
    } catch (e) {
      throw CacheException('Failed to save remember me preference: $e');
    }
  }

  @override
  Future<bool> getRememberMe() async {
    try {
      final rememberMe = await storageService.getBool(StorageConstants.keyRememberCredentials);
      return rememberMe ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAllAuthData() async {
    try {
      await Future.wait([
        clearAuthToken(),
        clearUserProfile(),
        clearUserPermissions(),
        storageService.remove(StorageConstants.keyRememberCredentials),
        storageService.remove(StorageConstants.keyAutoLogin),
        storageService.remove(StorageConstants.keyLastSyncTime),
      ]);
    } catch (e) {
      throw CacheException('Failed to clear all auth data: $e');
    }
  }

  /// Save authentication data from successful login
  @override
  Future<void> saveAuthData({
    required AuthTokenModel token,
    required UserModel user,
    required List<String> permissions,
    bool rememberMe = false,
  }) async {
    try {
      await Future.wait([
        saveAuthToken(token),
        saveUserProfile(user),
        saveUserPermissions(permissions),
        saveRememberMe(rememberMe),
      ]);
    } catch (e) {
      throw CacheException('Failed to save auth data: $e');
    }
  }

  /// Get complete authentication data
  Future<Map<String, dynamic>?> getAuthData() async {
    try {
      final token = await getAuthToken();
      final user = await getUserProfile();
      final permissions = await getUserPermissions();
      final rememberMe = await getRememberMe();

      if (token == null || user == null) {
        return null;
      }

      return {
        'token': token,
        'user': user,
        'permissions': permissions,
        'rememberMe': rememberMe,
      };
    } catch (e) {
      throw CacheException('Failed to get auth data: $e');
    }
  }

  /// Check if authentication data is complete
  Future<bool> hasCompleteAuthData() async {
    try {
      final authData = await getAuthData();
      return authData != null;
    } catch (e) {
      return false;
    }
  }

  /// Get user role quickly without loading full profile
  Future<String?> getUserRole() async {
    try {
      return await storageService.getString(StorageConstants.keyUserRole);
    } catch (e) {
      return null;
    }
  }

  /// Update last login time
  @override
  Future<void> updateLastLoginTime() async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      await storageService.setInt('last_login_time', now);
    } catch (e) {
      throw CacheException('Failed to update last login time: $e');
    }
  }

  /// Get last login time
  Future<DateTime?> getLastLoginTime() async {
    try {
      final timestamp = await storageService.getInt('last_login_time');
      if (timestamp == null) return null;
      
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e) {
      return null;
    }
  }
}