import 'package:equatable/equatable.dart';

/// Abstract failure class following Clean Architecture principles
/// All failures inherit from this base class
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure(this.message, [this.code]);
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() => 'Failure: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Server failure for API-related errors
class ServerFailure extends Failure {
  final int? statusCode;
  
  const ServerFailure(super.message, [this.statusCode, super.code]);
  
  @override
  List<Object?> get props => [message, code, statusCode];
}

/// Cache failure for local storage errors
class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

/// Network failure for connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.code]);
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}

/// Validation failure for form/input validation
class ValidationFailure extends Failure {
  final Map<String, String>? errors;
  
  const ValidationFailure(super.message, [this.errors, super.code]);
  
  @override
  List<Object?> get props => [message, code, errors];
}

/// Permission failure for unauthorized access
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, [super.code]);
}

/// File operation failure
class FileFailure extends Failure {
  const FileFailure(super.message, [super.code]);
}

/// Database failure for local database errors
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.code]);
}

/// Timeout failure for request timeouts
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message, [super.code]);
}

/// Format failure for data parsing errors
class FormatFailure extends Failure {
  const FormatFailure(super.message, [super.code]);
}

/// Unknown failure for unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure(super.message, [super.code]);
}