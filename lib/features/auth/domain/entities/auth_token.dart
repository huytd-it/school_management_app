import 'package:equatable/equatable.dart';

/// Authentication token entity
/// Contains access and refresh tokens for user authentication
class AuthToken extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final DateTime expiresAt;
  final DateTime refreshExpiresAt;
  final List<String>? scopes;

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresAt,
    required this.refreshExpiresAt,
    this.scopes,
  });

  /// Check if access token is expired
  bool get isAccessTokenExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  /// Check if refresh token is expired
  bool get isRefreshTokenExpired {
    return DateTime.now().isAfter(refreshExpiresAt);
  }

  /// Check if access token will expire soon (within 5 minutes)
  bool get willExpireSoon {
    final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));
    return fiveMinutesFromNow.isAfter(expiresAt);
  }

  /// Check if tokens are valid
  bool get isValid {
    return !isAccessTokenExpired && !isRefreshTokenExpired;
  }

  /// Get time until access token expires
  Duration get timeUntilExpiry {
    return expiresAt.difference(DateTime.now());
  }

  /// Get time until refresh token expires
  Duration get timeUntilRefreshExpiry {
    return refreshExpiresAt.difference(DateTime.now());
  }

  /// Get authorization header value
  String get authorizationHeader => '$tokenType $accessToken';

  /// Copy with new values
  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    DateTime? expiresAt,
    DateTime? refreshExpiresAt,
    List<String>? scopes,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenType: tokenType ?? this.tokenType,
      expiresAt: expiresAt ?? this.expiresAt,
      refreshExpiresAt: refreshExpiresAt ?? this.refreshExpiresAt,
      scopes: scopes ?? this.scopes,
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        tokenType,
        expiresAt,
        refreshExpiresAt,
        scopes,
      ];

  @override
  String toString() => 'AuthToken(tokenType: $tokenType, expiresAt: $expiresAt)';
}