import 'package:dio/dio.dart';
import '../../services/local_storage_service.dart';
import '../../constants/storage_constants.dart';

/// Authentication interceptor for automatic token management
/// Adds auth tokens to requests and handles token refresh
class AuthInterceptor extends Interceptor {
  final LocalStorageService _storageService;
  
  AuthInterceptor() : _storageService = LocalStorageService();
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from storage
    final accessToken = await _storageService.getString(StorageConstants.keyAccessToken);
    
    // Add authorization header if token exists
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token refresh if we get 401 Unauthorized
    if (err.response?.statusCode == 401) {
      final refreshToken = await _storageService.getString(StorageConstants.keyRefreshToken);
      
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Attempt to refresh token
          final newToken = await _refreshToken(refreshToken);
          
          if (newToken != null) {
            // Save new token
            await _storageService.setString(StorageConstants.keyAccessToken, newToken);
            
            // Retry original request with new token
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';
            
            final dio = Dio();
            final response = await dio.fetch(requestOptions);
            handler.resolve(response);
            return;
          }
        } catch (e) {
          // Refresh failed, clear tokens and redirect to login
          await _clearAuthTokens();
        }
      } else {
        // No refresh token available, clear any existing tokens
        await _clearAuthTokens();
      }
    }
    
    handler.next(err);
  }
  
  /// Refresh access token using refresh token
  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data['access_token'] as String?;
      }
    } catch (e) {
      // Refresh failed
      return null;
    }
    return null;
  }
  
  /// Clear authentication tokens from storage
  Future<void> _clearAuthTokens() async {
    await Future.wait([
      _storageService.remove(StorageConstants.keyAccessToken),
      _storageService.remove(StorageConstants.keyRefreshToken),
      _storageService.remove(StorageConstants.keyUserProfile),
      _storageService.remove(StorageConstants.keyUserRole),
      _storageService.remove(StorageConstants.keyUserPermissions),
    ]);
  }
}