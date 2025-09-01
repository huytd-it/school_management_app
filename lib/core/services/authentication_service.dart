import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'token_manager.dart';
import 'auth_models.dart';

/// Core authentication service handling all authentication methods
class AuthenticationService {
  static AuthenticationService? _instance;
  static AuthenticationService get instance {
    _instance ??= AuthenticationService._internal();
    return _instance!;
  }

  AuthenticationService._internal();

  TokenManager? _tokenManager;
  AuthUser? _currentUser;

  /// Initialize the authentication service
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _tokenManager = TokenManager(prefs);
    
    // Check if user is already authenticated
    await _restoreAuthState();
  }

  /// Restore authentication state from stored tokens
  Future<void> _restoreAuthState() async {
    if (_tokenManager == null) return;
    
    try {
      final isAuthenticated = await _tokenManager!.isAuthenticated();
      if (isAuthenticated) {
        final userData = await _tokenManager!.getUserData();
        if (userData != null) {
          _currentUser = AuthUser.fromMap(userData);
        }
      }
    } catch (e) {
      // If restoration fails, clear invalid tokens
      await _tokenManager!.clearAllTokens();
    }
  }

  /// Get current authenticated user
  AuthUser? get currentUser => _currentUser;

  /// Check if user is currently authenticated
  Future<bool> get isAuthenticated async {
    if (_tokenManager == null) return false;
    return await _tokenManager!.isAuthenticated();
  }

  /// Stream of authentication state changes
  Stream<AuthUser?> get authStateChanges {
    return Stream.periodic(const Duration(seconds: 1), (_) => _currentUser);
  }

  /// Sign in with email and password
  Future<AuthResult> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // For demo purposes, simulate authentication
      // In a real app, this would call your backend API
      
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.failure('Email and password are required');
      }

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data based on email
      final role = _determineRoleFromEmail(email);
      final userData = {
        'id': _generateUserId(),
        'email': email,
        'name': _extractNameFromEmail(email),
        'role': role,
        'provider': 'email',
        'photoUrl': null,
      };

      final user = AuthUser.fromMap(userData);
      final accessToken = _generateMockToken();
      
      // Store authentication data
      await _tokenManager!.storeAuthTokens(
        accessToken: accessToken,
        userData: userData,
        provider: 'email',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );

      _currentUser = user;

      return AuthResult.success(
        accessToken: accessToken,
        userData: userData,
        provider: 'email',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );
    } catch (e) {
      return AuthResult.failure('Authentication failed: ${e.toString()}');
    }
  }

  /// Sign in with Google (Mock implementation)
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Mock Google sign-in
      await Future.delayed(const Duration(seconds: 2));
      
      // Create mock Google user
      final userData = {
        'id': _generateUserId(),
        'email': 'google.user@gmail.com',
        'name': 'Google Demo User',
        'photoUrl': 'https://via.placeholder.com/150',
        'role': 'student',
        'provider': 'google',
      };

      final user = AuthUser.fromMap(userData);
      final accessToken = _generateMockToken();
      
      // Store authentication data
      await _tokenManager!.storeAuthTokens(
        accessToken: accessToken,
        userData: userData,
        provider: 'google',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );

      _currentUser = user;

      return AuthResult.success(
        accessToken: accessToken,
        userData: userData,
        provider: 'google',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );
    } catch (e) {
      return AuthResult.failure('Google authentication failed: ${e.toString()}');
    }
  }

  /// Sign in with Microsoft (Mock implementation)
  /// Note: For a real Microsoft integration, you would use the microsoft_graph_auth package
  Future<AuthResult> signInWithMicrosoft() async {
    try {
      // This is a mock implementation
      // In a real app, you would integrate with Microsoft Graph Auth
      
      // Simulate OAuth flow delay
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo, create a mock Microsoft user
      final userData = {
        'id': _generateUserId(),
        'email': 'demo.user@outlook.com',
        'name': 'Microsoft Demo User',
        'photoUrl': null,
        'role': 'student',
        'provider': 'microsoft',
      };

      final user = AuthUser.fromMap(userData);
      final accessToken = _generateMockToken();
      
      // Store authentication data
      await _tokenManager!.storeAuthTokens(
        accessToken: accessToken,
        userData: userData,
        provider: 'microsoft',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );

      _currentUser = user;

      return AuthResult.success(
        accessToken: accessToken,
        userData: userData,
        provider: 'microsoft',
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );
    } catch (e) {
      return AuthResult.failure('Microsoft authentication failed: ${e.toString()}');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      // Clear stored tokens
      await _tokenManager?.clearAllTokens();
      
      // Clear current user
      _currentUser = null;
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  /// Refresh authentication tokens
  Future<bool> refreshAuthentication() async {
    try {
      if (_tokenManager == null) return false;
      
      final refreshToken = await _tokenManager!.getRefreshToken();
      if (refreshToken == null) return false;
      
      // In a real app, you would call your backend to refresh tokens
      // For now, just extend the current token validity
      final newAccessToken = _generateMockToken();
      
      await _tokenManager!.updateAccessToken(
        newAccessToken,
        expiryTime: DateTime.now().add(const Duration(hours: 24)),
      );
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Helper method to determine user role from email
  String _determineRoleFromEmail(String email) {
    final emailLower = email.toLowerCase();
    
    if (emailLower.contains('admin')) return 'admin';
    if (emailLower.contains('teacher')) return 'teacher';
    if (emailLower.contains('parent')) return 'parent';
    return 'student'; // Default role
  }

  /// Extract name from email
  String _extractNameFromEmail(String email) {
    final parts = email.split('@');
    if (parts.isNotEmpty) {
      return parts[0].replaceAll('.', ' ').split(' ')
          .map((word) => word.isNotEmpty 
              ? word[0].toUpperCase() + word.substring(1) 
              : word)
          .join(' ');
    }
    return 'User';
  }

  /// Generate a mock user ID
  String _generateUserId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
  }

  /// Generate a mock authentication token
  String _generateMockToken() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(100000);
    return base64Encode(utf8.encode('mock_token_${timestamp}_$random'));
  }

  /// Dispose resources
  void dispose() {
    _instance = null;
  }
}