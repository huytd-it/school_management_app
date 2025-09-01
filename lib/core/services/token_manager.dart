import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages secure storage and retrieval of authentication tokens
class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _authProviderKey = 'auth_provider';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _encryptionKey = 'school_app_secret_key_2024';

  final SharedPreferences _prefs;

  TokenManager(this._prefs);

  /// Encrypts sensitive data before storage
  String _encrypt(String data) {
    final bytes = utf8.encode(data + _encryptionKey);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Stores authentication tokens securely
  Future<void> storeAuthTokens({
    required String accessToken,
    String? refreshToken,
    required Map<String, dynamic> userData,
    required String provider,
    DateTime? expiryTime,
  }) async {
    try {
      await _prefs.setString(_accessTokenKey, _encrypt(accessToken));
      
      if (refreshToken != null) {
        await _prefs.setString(_refreshTokenKey, _encrypt(refreshToken));
      }
      
      await _prefs.setString(_userDataKey, jsonEncode(userData));
      await _prefs.setString(_authProviderKey, provider);
      
      if (expiryTime != null) {
        await _prefs.setInt(_tokenExpiryKey, expiryTime.millisecondsSinceEpoch);
      }
    } catch (e) {
      throw Exception('Failed to store authentication tokens: $e');
    }
  }

  /// Retrieves the access token
  Future<String?> getAccessToken() async {
    try {
      return _prefs.getString(_accessTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Retrieves the refresh token
  Future<String?> getRefreshToken() async {
    try {
      return _prefs.getString(_refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Retrieves stored user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDataString = _prefs.getString(_userDataKey);
      if (userDataString != null) {
        return jsonDecode(userDataString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Retrieves the authentication provider
  Future<String?> getAuthProvider() async {
    try {
      return _prefs.getString(_authProviderKey);
    } catch (e) {
      return null;
    }
  }

  /// Checks if the stored token is still valid
  Future<bool> isTokenValid() async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken == null) return false;

      final expiryTimestamp = _prefs.getInt(_tokenExpiryKey);
      if (expiryTimestamp == null) return true; // No expiry set, assume valid

      final expiryTime = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
      return DateTime.now().isBefore(expiryTime);
    } catch (e) {
      return false;
    }
  }

  /// Checks if user is authenticated (has valid tokens)
  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null && await isTokenValid();
  }

  /// Clears all stored authentication data
  Future<void> clearAllTokens() async {
    try {
      await Future.wait([
        _prefs.remove(_accessTokenKey),
        _prefs.remove(_refreshTokenKey),
        _prefs.remove(_userDataKey),
        _prefs.remove(_authProviderKey),
        _prefs.remove(_tokenExpiryKey),
      ]);
    } catch (e) {
      throw Exception('Failed to clear authentication tokens: $e');
    }
  }

  /// Updates the access token (for token refresh scenarios)
  Future<void> updateAccessToken(String newAccessToken, {DateTime? expiryTime}) async {
    try {
      await _prefs.setString(_accessTokenKey, _encrypt(newAccessToken));
      
      if (expiryTime != null) {
        await _prefs.setInt(_tokenExpiryKey, expiryTime.millisecondsSinceEpoch);
      }
    } catch (e) {
      throw Exception('Failed to update access token: $e');
    }
  }

  /// Gets authentication summary for debugging
  Future<Map<String, dynamic>> getAuthSummary() async {
    return {
      'hasAccessToken': await getAccessToken() != null,
      'hasRefreshToken': await getRefreshToken() != null,
      'isAuthenticated': await isAuthenticated(),
      'isTokenValid': await isTokenValid(),
      'authProvider': await getAuthProvider(),
      'hasUserData': await getUserData() != null,
    };
  }
}