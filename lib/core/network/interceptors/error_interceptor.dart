import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../errors/error_handler.dart';

/// Error interceptor for centralized error handling
/// Logs errors and provides consistent error responses
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error for debugging
    ErrorHandler.logError(err, err.stackTrace);
    
    // Create user-friendly error message
    final friendlyError = _createFriendlyError(err);
    
    // Log friendly error for debugging
    if (kDebugMode) {
      print('=== FRIENDLY ERROR ===');
      print('Original: ${err.message}');
      print('Friendly: ${friendlyError.message}');
      print('Status Code: ${err.response?.statusCode}');
      print('======================');
    }
    
    // Pass the original error to the next handler
    handler.next(err);
  }
  
  /// Create user-friendly error messages
  DioException _createFriendlyError(DioException err) {
    String friendlyMessage;
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        friendlyMessage = 'Connection timeout. Please check your internet connection and try again.';
        break;
        
      case DioExceptionType.sendTimeout:
        friendlyMessage = 'Request timeout. Please try again.';
        break;
        
      case DioExceptionType.receiveTimeout:
        friendlyMessage = 'Server response timeout. Please try again.';
        break;
        
      case DioExceptionType.badResponse:
        friendlyMessage = _getResponseErrorMessage(err);
        break;
        
      case DioExceptionType.cancel:
        friendlyMessage = 'Request was cancelled.';
        break;
        
      case DioExceptionType.connectionError:
        friendlyMessage = 'No internet connection. Please check your network and try again.';
        break;
        
      default:
        friendlyMessage = 'An unexpected error occurred. Please try again.';
    }
    
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: friendlyMessage,
      message: friendlyMessage,
    );
  }
  
  /// Get user-friendly message for response errors
  String _getResponseErrorMessage(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;
    
    // Try to extract error message from response
    String? serverMessage;
    if (data is Map<String, dynamic>) {
      serverMessage = data['message'] as String? ?? 
                     data['error'] as String? ?? 
                     data['detail'] as String?;
    }
    
    switch (statusCode) {
      case 400:
        return serverMessage ?? 'Invalid request. Please check your input and try again.';
        
      case 401:
        return 'Your session has expired. Please login again.';
        
      case 403:
        return 'You don\'t have permission to perform this action.';
        
      case 404:
        return 'The requested information could not be found.';
        
      case 422:
        return serverMessage ?? 'Please check your input and try again.';
        
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
        
      case 500:
        return 'Server error. Please try again later.';
        
      case 502:
        return 'Service temporarily unavailable. Please try again later.';
        
      case 503:
        return 'Service maintenance in progress. Please try again later.';
        
      default:
        return serverMessage ?? 'An error occurred. Please try again.';
    }
  }
}