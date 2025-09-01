import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_token.dart';

part 'auth_token_model.g.dart';

/// Authentication token model for data layer
/// Handles JSON serialization/deserialization
@JsonSerializable()
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.tokenType,
    required super.expiresAt,
    required super.refreshExpiresAt,
    super.scopes,
  });

  /// Create from JSON
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) => _$AuthTokenModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);

  /// Create from domain entity
  factory AuthTokenModel.fromEntity(AuthToken token) {
    return AuthTokenModel(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      tokenType: token.tokenType,
      expiresAt: token.expiresAt,
      refreshExpiresAt: token.refreshExpiresAt,
      scopes: token.scopes,
    );
  }

  /// Convert to domain entity
  AuthToken toEntity() {
    return AuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresAt: expiresAt,
      refreshExpiresAt: refreshExpiresAt,
      scopes: scopes,
    );
  }

  /// Create from API response
  factory AuthTokenModel.fromApiResponse(Map<String, dynamic> json) {
    // Handle different API response formats
    final accessToken = json['access_token'] as String;
    final refreshToken = json['refresh_token'] as String;
    final tokenType = json['token_type'] as String? ?? 'Bearer';
    
    // Parse expiry times
    final expiresIn = json['expires_in'] as int? ?? 3600; // Default 1 hour
    final refreshExpiresIn = json['refresh_expires_in'] as int? ?? 86400; // Default 24 hours
    
    final now = DateTime.now();
    final expiresAt = now.add(Duration(seconds: expiresIn));
    final refreshExpiresAt = now.add(Duration(seconds: refreshExpiresIn));
    
    // Parse scopes
    List<String>? scopes;
    if (json['scope'] != null) {
      if (json['scope'] is String) {
        scopes = (json['scope'] as String).split(' ');
      } else if (json['scope'] is List) {
        scopes = List<String>.from(json['scope']);
      }
    }

    return AuthTokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresAt: expiresAt,
      refreshExpiresAt: refreshExpiresAt,
      scopes: scopes,
    );
  }

  /// Copy with new values
  AuthTokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    DateTime? expiresAt,
    DateTime? refreshExpiresAt,
    List<String>? scopes,
  }) {
    return AuthTokenModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenType: tokenType ?? this.tokenType,
      expiresAt: expiresAt ?? this.expiresAt,
      refreshExpiresAt: refreshExpiresAt ?? this.refreshExpiresAt,
      scopes: scopes ?? this.scopes,
    );
  }
}