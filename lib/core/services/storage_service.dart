import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Service for managing local storage using SharedPreferences
class StorageService {
  late final SharedPreferences _prefs;
  
  /// Initialize storage service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Auth Token Management
  
  /// Save auth token
  Future<bool> saveAuthToken(String token) async {
    return await _prefs.setString(AppConstants.authTokenKey, token);
  }
  
  /// Get auth token
  Future<String?> getAuthToken() async {
    return _prefs.getString(AppConstants.authTokenKey);
  }
  
  /// Save refresh token
  Future<bool> saveRefreshToken(String token) async {
    return await _prefs.setString(AppConstants.refreshTokenKey, token);
  }
  
  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return _prefs.getString(AppConstants.refreshTokenKey);
  }
  
  /// Clear auth data
  Future<void> clearAuthData() async {
    await _prefs.remove(AppConstants.authTokenKey);
    await _prefs.remove(AppConstants.refreshTokenKey);
    await _prefs.remove(AppConstants.userDataKey);
  }
  
  // User Data Management
  
  /// Save user data as JSON
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    final jsonString = jsonEncode(userData);
    return await _prefs.setString(AppConstants.userDataKey, jsonString);
  }
  
  /// Get user data
  Map<String, dynamic>? getUserData() {
    final jsonString = _prefs.getString(AppConstants.userDataKey);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }
  
  // App Settings
  
  /// Save theme mode
  Future<bool> saveThemeMode(String themeMode) async {
    return await _prefs.setString(AppConstants.themeKey, themeMode);
  }
  
  /// Get theme mode
  String? getThemeMode() {
    return _prefs.getString(AppConstants.themeKey);
  }
  
  /// Save language code
  Future<bool> saveLanguageCode(String languageCode) async {
    return await _prefs.setString(AppConstants.languageKey, languageCode);
  }
  
  /// Get language code
  String? getLanguageCode() {
    return _prefs.getString(AppConstants.languageKey);
  }
  
  /// Check if first time
  bool isFirstTime() {
    return _prefs.getBool(AppConstants.firstTimeKey) ?? true;
  }
  
  /// Set first time flag
  Future<bool> setFirstTime(bool value) async {
    return await _prefs.setBool(AppConstants.firstTimeKey, value);
  }
  
  // Generic Storage Methods
  
  /// Save string value
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  
  /// Get string value
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  /// Save int value
  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }
  
  /// Get int value
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  /// Save bool value
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  
  /// Get bool value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  /// Save double value
  Future<bool> saveDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }
  
  /// Get double value
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }
  
  /// Save string list
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }
  
  /// Get string list
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }
  
  /// Remove value
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  /// Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
  
  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}