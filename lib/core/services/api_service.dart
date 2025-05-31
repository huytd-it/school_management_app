import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'storage_service.dart';

/// Main API service with JWT token handling and interceptors
class ApiService {
  late final Dio _dio;
  final StorageService _storageService;
  String? _authToken;
  String? _refreshToken;
  
  ApiService({required StorageService storageService}) 
      : _storageService = storageService {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _setupInterceptors();
    _loadTokens();
  }
  
  /// Setup Dio interceptors for token management and error handling
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token to headers if available
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          
          // Log request in debug mode
          print('🌐 API Request: ${options.method} ${options.path}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          
          handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response in debug mode
          print('✅ API Response: ${response.statusCode} ${response.requestOptions.path}');
          print('Data: ${response.data}');
          
          handler.next(response);
        },
        onError: (error, handler) async {
          print('❌ API Error: ${error.response?.statusCode} ${error.requestOptions.path}');
          print('Error: ${error.message}');
          
          // Handle 401 Unauthorized - try to refresh token
          if (error.response?.statusCode == 401 && _refreshToken != null) {
            try {
              await _refreshAccessToken();
              // Retry the request with new token
              final response = await _retry(error.requestOptions);
              handler.resolve(response);
              return;
            } catch (e) {
              // Refresh failed, logout user
              await _clearTokens();
              handler.reject(error);
              return;
            }
          }
          
          handler.next(error);
        },
      ),
    );
    
    // Add logging interceptor in debug mode
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
  }
  
  /// Load tokens from storage
  Future<void> _loadTokens() async {
    _authToken = await _storageService.getAuthToken();
    _refreshToken = await _storageService.getRefreshToken();
  }
  
  /// Set authentication tokens
  Future<void> setTokens({
    required String authToken,
    required String refreshToken,
  }) async {
    _authToken = authToken;
    _refreshToken = refreshToken;
    
    await _storageService.saveAuthToken(authToken);
    await _storageService.saveRefreshToken(refreshToken);
  }
  
  /// Clear authentication tokens
  Future<void> _clearTokens() async {
    _authToken = null;
    _refreshToken = null;
    
    await _storageService.clearAuthData();
  }
  
  /// Refresh access token using refresh token
  Future<void> _refreshAccessToken() async {
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refreshToken': _refreshToken},
      options: Options(
        headers: {'Authorization': null}, // Don't send expired token
      ),
    );
    
    final newAuthToken = response.data['token'];
    final newRefreshToken = response.data['refreshToken'];
    
    await setTokens(
      authToken: newAuthToken,
      refreshToken: newRefreshToken,
    );
  }
  
  /// Retry failed request with new token
  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $_authToken',
      },
    );
    
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
  
  // HTTP Methods
  
  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Upload file
  Future<Response> uploadFile(
    String path, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? data,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fieldName: await MultipartFile.fromFile(filePath),
      });
      
      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );
      
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Handle API errors
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: null,
        );
        
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        String message = 'An error occurred';
        
        if (data != null && data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        }
        
        return ApiException(
          message: message,
          statusCode: statusCode,
        );
        
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request cancelled',
          statusCode: null,
        );
        
      default:
        return ApiException(
          message: 'No internet connection',
          statusCode: null,
        );
    }
  }
}

/// Custom API Exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException({
    required this.message,
    this.statusCode,
  });
  
  @override
  String toString() => message;
}