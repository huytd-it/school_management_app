/// Authentication result data model
class AuthResult {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final Map<String, dynamic>? userData;
  final String? provider;
  final String? errorMessage;
  final DateTime? expiryTime;

  const AuthResult({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.userData,
    this.provider,
    this.errorMessage,
    this.expiryTime,
  });

  factory AuthResult.success({
    required String accessToken,
    String? refreshToken,
    required Map<String, dynamic> userData,
    required String provider,
    DateTime? expiryTime,
  }) {
    return AuthResult(
      success: true,
      accessToken: accessToken,
      refreshToken: refreshToken,
      userData: userData,
      provider: provider,
      expiryTime: expiryTime,
    );
  }

  factory AuthResult.failure(String errorMessage) {
    return AuthResult(
      success: false,
      errorMessage: errorMessage,
    );
  }
}

/// User data model for authentication
class AuthUser {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String role;
  final String provider;

  const AuthUser({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.role,
    required this.provider,
  });

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'] ?? 'student',
      provider: map['provider'] ?? 'email',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'provider': provider,
    };
  }
}

/// Authentication provider types
enum AuthProvider {
  email,
  google,
  microsoft,
}

extension AuthProviderExtension on AuthProvider {
  String get name {
    switch (this) {
      case AuthProvider.email:
        return 'email';
      case AuthProvider.google:
        return 'google';
      case AuthProvider.microsoft:
        return 'microsoft';
    }
  }
}