/// Custom exceptions for the application
/// Following Clean Architecture principles for error handling

/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  final Map<String, String>? errors;
  
  const ValidationException(super.message, [this.errors, super.code]);
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException(super.message, [super.code]);
}

/// File operation exceptions
class FileException extends AppException {
  const FileException(super.message, [super.code]);
}

/// Database-related exceptions
class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.code]);
}

/// Timeout exceptions
class TimeoutException extends AppException {
  const TimeoutException(super.message, [super.code]);
}

/// Format exceptions for data parsing
class FormatException extends AppException {
  const FormatException(super.message, [super.code]);
}