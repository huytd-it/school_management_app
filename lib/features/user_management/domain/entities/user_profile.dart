import 'package:equatable/equatable.dart';
import '../../../../shared/enums/user_role.dart';

/// Extended user profile entity for user management
/// Contains additional profile information beyond basic auth user
class UserProfile extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? phone;
  final String? avatar;
  final String? address;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final DateTime? dateOfBirth;
  final String? gender;
  final UserRole role;
  final List<String> permissions;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final String? bio;
  final Map<String, dynamic>? socialLinks;
  final Map<String, dynamic>? preferences;
  final Map<String, dynamic>? metadata;

  const UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.phone,
    this.avatar,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.dateOfBirth,
    this.gender,
    required this.role,
    required this.permissions,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.bio,
    this.socialLinks,
    this.preferences,
    this.metadata,
  });

  /// Get full name
  String get fullName {
    final middle = middleName != null ? ' $middleName' : '';
    return '$firstName$middle $lastName';
  }

  /// Get display name
  String get displayName => '$firstName ${lastName.isNotEmpty ? lastName[0].toUpperCase() : ''}';

  /// Get initials
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  /// Get age if date of birth is available
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    final age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month || 
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      return age - 1;
    }
    return age;
  }

  /// Check if profile is complete
  bool get isProfileComplete {
    return firstName.isNotEmpty &&
           lastName.isNotEmpty &&
           email.isNotEmpty &&
           phone != null &&
           phone!.isNotEmpty;
  }

  /// Get completion percentage
  double get completionPercentage {
    int completed = 0;
    int total = 10;

    if (firstName.isNotEmpty) completed++;
    if (lastName.isNotEmpty) completed++;
    if (email.isNotEmpty) completed++;
    if (phone != null && phone!.isNotEmpty) completed++;
    if (avatar != null) completed++;
    if (address != null && address!.isNotEmpty) completed++;
    if (dateOfBirth != null) completed++;
    if (gender != null) completed++;
    if (bio != null && bio!.isNotEmpty) completed++;
    if (isEmailVerified) completed++;

    return (completed / total) * 100;
  }

  /// Copy with new values
  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phone,
    String? avatar,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    DateTime? dateOfBirth,
    String? gender,
    UserRole? role,
    List<String>? permissions,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? bio,
    Map<String, dynamic>? socialLinks,
    Map<String, dynamic>? preferences,
    Map<String, dynamic>? metadata,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      bio: bio ?? this.bio,
      socialLinks: socialLinks ?? this.socialLinks,
      preferences: preferences ?? this.preferences,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        middleName,
        phone,
        avatar,
        address,
        city,
        state,
        zipCode,
        country,
        dateOfBirth,
        gender,
        role,
        permissions,
        isEmailVerified,
        isPhoneVerified,
        isActive,
        createdAt,
        updatedAt,
        lastLoginAt,
        bio,
        socialLinks,
        preferences,
        metadata,
      ];

  @override
  String toString() => 'UserProfile(id: $id, email: $email, name: $fullName, role: ${role.displayName})';
}