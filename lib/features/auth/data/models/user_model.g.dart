// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isEmailVerified: json['isEmailVerified'] as bool,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'role': _$UserRoleEnumMap[instance.role]!,
      'permissions': instance.permissions,
      'isEmailVerified': instance.isEmailVerified,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'superAdmin',
  UserRole.admin: 'admin',
  UserRole.principal: 'principal',
  UserRole.vicePrincipal: 'vicePrincipal',
  UserRole.teacher: 'teacher',
  UserRole.student: 'student',
  UserRole.parent: 'parent',
  UserRole.staff: 'staff',
  UserRole.librarian: 'librarian',
  UserRole.accountant: 'accountant',
  UserRole.receptionist: 'receptionist',
  UserRole.security: 'security',
  UserRole.janitor: 'janitor',
  UserRole.guest: 'guest',
};
