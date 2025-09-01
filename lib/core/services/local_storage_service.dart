import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_constants.dart';

/// Local storage service for managing persistent data
/// Provides secure storage for app settings, user preferences, and cache
abstract class LocalStorageService {
  // String operations
  Future<bool> setString(String key, String value);
  Future<String?> getString(String key);
  
  // Integer operations
  Future<bool> setInt(String key, int value);
  Future<int?> getInt(String key);
  
  // Double operations
  Future<bool> setDouble(String key, double value);
  Future<double?> getDouble(String key);
  
  // Boolean operations
  Future<bool> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  
  // List operations
  Future<bool> setStringList(String key, List<String> value);
  Future<List<String>?> getStringList(String key);
  
  // Object operations (JSON)
  Future<bool> setObject(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> getObject(String key);
  
  // Remove operations
  Future<bool> remove(String key);
  Future<bool> clear();
  
  // Utility operations
  Future<bool> containsKey(String key);
  Future<Set<String>> getKeys();
}

class LocalStorageServiceImpl implements LocalStorageService {
  SharedPreferences? _prefs;
  
  /// Initialize SharedPreferences
  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  @override
  Future<bool> setString(String key, String value) async {
    await _init();
    return await _prefs!.setString(key, value);
  }
  
  @override
  Future<String?> getString(String key) async {
    await _init();
    return _prefs!.getString(key);
  }
  
  @override
  Future<bool> setInt(String key, int value) async {
    await _init();
    return await _prefs!.setInt(key, value);
  }
  
  @override
  Future<int?> getInt(String key) async {
    await _init();
    return _prefs!.getInt(key);
  }
  
  @override
  Future<bool> setDouble(String key, double value) async {
    await _init();
    return await _prefs!.setDouble(key, value);
  }
  
  @override
  Future<double?> getDouble(String key) async {
    await _init();
    return _prefs!.getDouble(key);
  }
  
  @override
  Future<bool> setBool(String key, bool value) async {
    await _init();
    return await _prefs!.setBool(key, value);
  }
  
  @override
  Future<bool?> getBool(String key) async {
    await _init();
    return _prefs!.getBool(key);
  }
  
  @override
  Future<bool> setStringList(String key, List<String> value) async {
    await _init();
    return await _prefs!.setStringList(key, value);
  }
  
  @override
  Future<List<String>?> getStringList(String key) async {
    await _init();
    return _prefs!.getStringList(key);
  }
  
  @override
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    await _init();
    final jsonString = json.encode(value);
    return await _prefs!.setString(key, jsonString);
  }
  
  @override
  Future<Map<String, dynamic>?> getObject(String key) async {
    await _init();
    final jsonString = _prefs!.getString(key);
    if (jsonString == null) return null;
    
    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<bool> remove(String key) async {
    await _init();
    return await _prefs!.remove(key);
  }
  
  @override
  Future<bool> clear() async {
    await _init();
    return await _prefs!.clear();
  }
  
  @override
  Future<bool> containsKey(String key) async {
    await _init();
    return _prefs!.containsKey(key);
  }
  
  @override
  Future<Set<String>> getKeys() async {
    await _init();
    return _prefs!.getKeys();
  }
  
  /// Save user authentication tokens
  Future<bool> saveAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final results = await Future.wait([
      setString(StorageConstants.keyAccessToken, accessToken),
      setString(StorageConstants.keyRefreshToken, refreshToken),
    ]);
    return results.every((result) => result);
  }
  
  /// Get user authentication tokens
  Future<Map<String, String?>> getAuthTokens() async {
    final results = await Future.wait([
      getString(StorageConstants.keyAccessToken),
      getString(StorageConstants.keyRefreshToken),
    ]);
    
    return {
      'accessToken': results[0],
      'refreshToken': results[1],
    };
  }
  
  /// Clear user authentication tokens
  Future<bool> clearAuthTokens() async {
    final results = await Future.wait([
      remove(StorageConstants.keyAccessToken),
      remove(StorageConstants.keyRefreshToken),
      remove(StorageConstants.keyUserProfile),
      remove(StorageConstants.keyUserRole),
      remove(StorageConstants.keyUserPermissions),
    ]);
    return results.every((result) => result);
  }
  
  /// Save user profile
  Future<bool> saveUserProfile(Map<String, dynamic> profile) async {
    return await setObject(StorageConstants.keyUserProfile, profile);
  }
  
  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    return await getObject(StorageConstants.keyUserProfile);
  }
  
  /// Save user preferences
  Future<bool> saveUserPreferences(Map<String, dynamic> preferences) async {
    return await setObject(StorageConstants.keyUserPreferences, preferences);
  }
  
  /// Get user preferences
  Future<Map<String, dynamic>?> getUserPreferences() async {
    return await getObject(StorageConstants.keyUserPreferences);
  }
  
  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final accessToken = await getString(StorageConstants.keyAccessToken);
    return accessToken != null && accessToken.isNotEmpty;
  }
  
  /// Check if this is first app launch
  Future<bool> isFirstLaunch() async {
    final isFirst = await getBool(StorageConstants.keyIsFirstLaunch);
    return isFirst ?? true;
  }
  
  /// Mark first launch as completed
  Future<bool> markFirstLaunchCompleted() async {
    return await setBool(StorageConstants.keyIsFirstLaunch, false);
  }
}