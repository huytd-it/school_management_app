import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Global error handler for the application
/// Converts exceptions to failures and provides error mapping
class ErrorHandler {
  /// Convert exception to failure
  static Failure handleException(Exception exception) {
    if (exception is DioException) {
      return _handleDioException(exception);
    }
    
    if (exception is ServerException) {
      return ServerFailure(exception.message, null, exception.code);
    }
    
    if (exception is CacheException) {
      return CacheFailure(exception.message, exception.code);
    }
    
    if (exception is NetworkException) {
      return NetworkFailure(exception.message, exception.code);
    }
    
    if (exception is AuthException) {
      return AuthFailure(exception.message, exception.code);
    }
    
    if (exception is ValidationException) {
      return ValidationFailure(exception.message, exception.errors, exception.code);
    }
    
    if (exception is PermissionException) {
      return PermissionFailure(exception.message, exception.code);
    }
    
    if (exception is FileException) {
      return FileFailure(exception.message, exception.code);
    }
    
    if (exception is DatabaseException) {
      return DatabaseFailure(exception.message, exception.code);
    }
    
    if (exception is TimeoutException) {
      return TimeoutFailure(exception.message, exception.code);
    }
    
    if (exception is FormatException) {
      return FormatFailure(exception.message, exception.code);
    }
    
    // Default to unknown failure
    return UnknownFailure(
      exception.toString(),
      'UNKNOWN_ERROR',
    );
  }
  
  /// Handle Dio specific exceptions
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure(
          'Connection timeout. Please check your internet connection.',
          'TIMEOUT_ERROR',
        );
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);
        
      case DioExceptionType.cancel:
        return const UnknownFailure(
          'Request was cancelled.',
          'REQUEST_CANCELLED',
        );
        
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network.',
          'NO_INTERNET',
        );
        
      default:
        return UnknownFailure(
          'Unexpected error occurred: ${exception.message}',
          'UNKNOWN_DIO_ERROR',
        );
    }
  }
  
  /// Handle bad response from server
  static Failure _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final data = exception.response?.data;
    
    switch (statusCode) {
      case 400:
        return ServerFailure(
          _extractErrorMessage(data) ?? 'Bad request.',
          statusCode,
          'BAD_REQUEST',
        );
        
      case 401:
        return const AuthFailure(
          'Unauthorized. Please login again.',
          'UNAUTHORIZED',
        );
        
      case 403:
        return const PermissionFailure(
          'Access forbidden. You don\'t have permission.',
          'FORBIDDEN',
        );
        
      case 404:
        return ServerFailure(
          'Resource not found.',
          statusCode,
          'NOT_FOUND',
        );
        
      case 422:
        return ValidationFailure(
          _extractErrorMessage(data) ?? 'Validation failed.',
          _extractValidationErrors(data),
          'VALIDATION_ERROR',
        );
        
      case 500:
        return ServerFailure(
          'Internal server error. Please try again later.',
          statusCode,
          'INTERNAL_SERVER_ERROR',
        );
        
      default:
        return ServerFailure(
          _extractErrorMessage(data) ?? 'Server error occurred.',
          statusCode,
          'SERVER_ERROR',
        );
    }
  }
  
  /// Extract error message from response data
  static String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? 
             data['error'] as String? ?? 
             data['detail'] as String?;
    }
    return data?.toString();
  }
  
  /// Extract validation errors from response data
  static Map<String, String>? _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'] ?? data['validation_errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map((key, value) => MapEntry(
          key,
          value is List ? value.first.toString() : value.toString(),
        ));
      }
    }
    return null;
  }
  
  /// Log error for debugging
  static void logError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print('=== ERROR LOG ===');
      print('Error: $error');
      if (stackTrace != null) {
        print('Stack Trace: $stackTrace');
      }
      print('=================');
    }
  }
}

/// Extension to add error handling methods to common types
extension ErrorHandlerExtension on Exception {
  Failure toFailure() => ErrorHandler.handleException(this);
}