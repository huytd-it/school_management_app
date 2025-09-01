import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

// Core services
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../services/local_storage_service.dart';
import '../services/cache_service.dart';

// Authentication feature
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/domain/usecases/password_usecases.dart';
import '../../features/auth/domain/usecases/user_usecases.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

/// Dependency injection container using GetIt
/// Manages all app dependencies with proper lifecycle
final sl = GetIt.instance;

/// Initialize all dependencies
/// Call this in main.dart before runApp()
Future<void> initializeDependencies() async {
  // External dependencies
  await _initExternalDependencies();
  
  // Core services
  _initCoreServices();
  
  // Feature dependencies
  _initAuthFeature();
  
  // Initialize services that need async setup
  await _initAsyncServices();
}

/// Initialize external dependencies (third-party packages)
Future<void> _initExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  
  // Dio for HTTP requests
  sl.registerLazySingleton<Dio>(() => Dio());
}

/// Initialize core services
void _initCoreServices() {
  // Network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );
  
  // Local storage service
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(),
  );
  
  // Cache service
  sl.registerLazySingleton<CacheService>(
    () => CacheServiceImpl(sl<LocalStorageService>()),
  );
  
  // API client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );
}

/// Initialize authentication feature dependencies
void _initAuthFeature() {
  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      storageService: sl<LocalStorageService>(),
    ),
  );
  
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(),
    ),
  );
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(sl<AuthRepository>()),
  );
  
  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(sl<AuthRepository>()),
  );
  
  // BLoC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      refreshTokenUseCase: sl<RefreshTokenUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
}

/// Initialize services that require async setup
Future<void> _initAsyncServices() async {
  // Any services that need async initialization can be set up here
  // For example, if we need to warm up caches or check initial auth state
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}

/// Check if a dependency is registered
bool isDependencyRegistered<T extends Object>() {
  return sl.isRegistered<T>();
}

/// Get a dependency (with type safety)
T getDependency<T extends Object>() {
  if (!sl.isRegistered<T>()) {
    throw Exception('Dependency $T is not registered. Make sure to call initializeDependencies() first.');
  }
  return sl<T>();
}

/// Register a dependency manually (for testing or special cases)
void registerDependency<T extends Object>(T dependency, {bool replace = false}) {
  if (sl.isRegistered<T>()) {
    if (replace) {
      sl.unregister<T>();
    } else {
      throw Exception('Dependency $T is already registered. Use replace: true to override.');
    }
  }
  sl.registerSingleton<T>(dependency);
}

/// Unregister a dependency
void unregisterDependency<T extends Object>() {
  if (sl.isRegistered<T>()) {
    sl.unregister<T>();
  }
}