import 'package:get_it/get_it.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

/// Dependency injection container using GetIt
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Services
  sl.registerLazySingleton<StorageService>(() => StorageService());
  sl.registerLazySingleton<ApiService>(
    () => ApiService(storageService: sl<StorageService>()),
  );
  
  // Initialize storage service
  await sl<StorageService>().init();
  
  // TODO: Register repositories, use cases, and blocs as we create them
  // Example:
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(apiService: sl<ApiService>()),
  // );
  
  // sl.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(repository: sl<AuthRepository>()),
  // );
  
  // sl.registerFactory<AuthBloc>(
  //   () => AuthBloc(
  //     loginUseCase: sl<LoginUseCase>(),
  //     storageService: sl<StorageService>(),
  //   ),
  // );
}