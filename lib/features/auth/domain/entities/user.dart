import 'package:equatable/equatable.dart';
import '../../../../shared/enums/user_role.dart';

/// User entity representing an authenticated user in the system
/// Following Clean Architecture principles - pure business logic
class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? avatar;
  final UserRole role;
  final List<String> permissions;
  final bool isEmailVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? metadata;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.avatar,
    required this.role,
    required this.permissions,
    required this.isEmailVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.metadata,
  });

  /// Get full name
  String get fullName => '$firstName $lastName';

  /// Get display name (first name + last initial)
  String get displayName => '$firstName ${lastName.isNotEmpty ? lastName[0].toUpperCase() : ''}';

  /// Get initials for avatar
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  /// Check if user has specific permission
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  /// Check if user has any of the specified permissions
  bool hasAnyPermission(List<String> permissionList) {
    return permissionList.any((permission) => permissions.contains(permission));
  }

  /// Check if user has all specified permissions
  bool hasAllPermissions(List<String> permissionList) {
    return permissionList.every((permission) => permissions.contains(permission));
  }

  /// Check if user can access module
  bool canAccessModule(String module) {
    return role.availableModules.contains(module);
  }

  /// Check if user is admin
  bool get isAdmin => role.isAdmin;

  /// Check if user is management
  bool get isManagement => role.isManagement;

  /// Check if user is academic staff
  bool get isAcademicStaff => role.isAcademic;

  /// Check if user is support staff
  bool get isSupportStaff => role.isSupport;

  /// Get user's primary dashboard route
  String get dashboardRoute => role.defaultDashboardRoute;

  /// Copy with new values
  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
    UserRole? role,
    List<String>? permissions,
    bool? isEmailVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phone,
        avatar,
        role,
        permissions,
        isEmailVerified,
        isActive,
        createdAt,
        updatedAt,
        lastLoginAt,
        metadata,
      ];

  @override
  String toString() => 'User(id: $id, email: $email, name: $fullName, role: ${role.displayName})';
}