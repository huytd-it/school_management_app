import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logger interceptor for development debugging
/// Logs HTTP requests and responses in debug mode
class LoggerInterceptor extends Interceptor {
  static const int maxLogLength = 1000;
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      _logRequest(options);
    }
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _logResponse(response);
    }
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      _logError(err);
    }
    handler.next(err);
  }
  
  /// Log HTTP request details
  void _logRequest(RequestOptions options) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ 🚀 REQUEST');
    print('├─────────────────────────────────────────────────────────────');
    print('│ Method: ${options.method}');
    print('│ URL: ${options.uri}');
    
    if (options.headers.isNotEmpty) {
      print('│ Headers:');
      options.headers.forEach((key, value) {
        // Don't log sensitive headers
        if (_isSensitiveHeader(key)) {
          print('│   $key: [HIDDEN]');
        } else {
          print('│   $key: $value');
        }
      });
    }
    
    if (options.queryParameters.isNotEmpty) {
      print('│ Query Parameters:');
      options.queryParameters.forEach((key, value) {
        print('│   $key: $value');
      });
    }
    
    if (options.data != null) {
      print('│ Body:');
      final bodyString = _formatData(options.data);
      if (bodyString.length > maxLogLength) {
        print('│   ${bodyString.substring(0, maxLogLength)}...[TRUNCATED]');
      } else {
        print('│   $bodyString');
      }
    }
    
    print('└─────────────────────────────────────────────────────────────');
  }
  
  /// Log HTTP response details
  void _logResponse(Response response) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ ✅ RESPONSE');
    print('├─────────────────────────────────────────────────────────────');
    print('│ Status Code: ${response.statusCode}');
    print('│ URL: ${response.requestOptions.uri}');
    
    if (response.headers.map.isNotEmpty) {
      print('│ Headers:');
      response.headers.map.forEach((key, value) {
        print('│   $key: ${value.join(', ')}');
      });
    }
    
    if (response.data != null) {
      print('│ Body:');
      final bodyString = _formatData(response.data);
      if (bodyString.length > maxLogLength) {
        print('│   ${bodyString.substring(0, maxLogLength)}...[TRUNCATED]');
      } else {
        print('│   $bodyString');
      }
    }
    
    print('└─────────────────────────────────────────────────────────────');
  }
  
  /// Log HTTP error details
  void _logError(DioException err) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ ❌ ERROR');
    print('├─────────────────────────────────────────────────────────────');
    print('│ Type: ${err.type}');
    print('│ Message: ${err.message}');
    print('│ URL: ${err.requestOptions.uri}');
    
    if (err.response != null) {
      print('│ Status Code: ${err.response!.statusCode}');
      if (err.response!.data != null) {
        print('│ Error Body:');
        final bodyString = _formatData(err.response!.data);
        if (bodyString.length > maxLogLength) {
          print('│   ${bodyString.substring(0, maxLogLength)}...[TRUNCATED]');
        } else {
          print('│   $bodyString');
        }
      }
    }
    
    print('└─────────────────────────────────────────────────────────────');
  }
  
  /// Format data for logging
  String _formatData(dynamic data) {
    if (data == null) return 'null';
    
    try {
      if (data is Map || data is List) {
        return data.toString();
      } else if (data is FormData) {
        return 'FormData with ${data.fields.length} fields and ${data.files.length} files';
      } else {
        return data.toString();
      }
    } catch (e) {
      return '[Failed to format data: $e]';
    }
  }
  
  /// Check if header contains sensitive information
  bool _isSensitiveHeader(String key) {
    final sensitiveHeaders = [
      'authorization',
      'cookie',
      'x-api-key',
      'x-auth-token',
      'bearer',
    ];
    
    return sensitiveHeaders.any(
      (header) => key.toLowerCase().contains(header),
    );
  }
}