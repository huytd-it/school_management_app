import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/auth_models.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC for managing authentication state throughout the application
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService _authService;
  StreamSubscription<AuthUser?>? _authSubscription;

  AuthBloc({AuthenticationService? authService})
      : _authService = authService ?? AuthenticationService.instance,
        super(const AuthInitial()) {
    
    // Register event handlers
    on<AuthStatusChecked>(_onAuthStatusChecked);
    on<AuthEmailLoginRequested>(_onEmailLoginRequested);
    on<AuthGoogleLoginRequested>(_onGoogleLoginRequested);
    on<AuthMicrosoftLoginRequested>(_onMicrosoftLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthTokenRefreshRequested>(_onTokenRefreshRequested);
    on<AuthStateChanged>(_onAuthStateChanged);

    // Initialize authentication service
    _initializeAuthService();
  }

  /// Initialize the authentication service and check initial auth state
  Future<void> _initializeAuthService() async {
    try {
      await _authService.initialize();
      add(const AuthStatusChecked());
      
      // Listen to authentication state changes
      _authSubscription = _authService.authStateChanges.listen((user) {
        if (user != null && state is! AuthAuthenticated) {
          add(const AuthStateChanged(true));
        } else if (user == null && state is! AuthUnauthenticated) {
          add(const AuthStateChanged(false));
        }
      });
    } catch (e) {
      emit(AuthError(message: 'Failed to initialize authentication: ${e.toString()}'));
    }
  }

  /// Handle authentication status check
  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading(message: 'Checking authentication status...'));
      
      final isAuthenticated = await _authService.isAuthenticated;
      
      if (isAuthenticated && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: 'Failed to check authentication status: ${e.toString()}'));
    }
  }

  /// Handle email/password login
  Future<void> _onEmailLoginRequested(
    AuthEmailLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoginInProgress('email'));
      
      final result = await _authService.signInWithEmailPassword(
        email: event.email,
        password: event.password,
      );
      
      if (result.success && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(AuthError(message: result.errorMessage ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthError(message: 'Email login failed: ${e.toString()}'));
    }
  }

  /// Handle Google login
  Future<void> _onGoogleLoginRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoginInProgress('google'));
      
      final result = await _authService.signInWithGoogle();
      
      if (result.success && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(AuthError(message: result.errorMessage ?? 'Google login failed'));
      }
    } catch (e) {
      emit(AuthError(message: 'Google login failed: ${e.toString()}'));
    }
  }

  /// Handle Microsoft login
  Future<void> _onMicrosoftLoginRequested(
    AuthMicrosoftLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoginInProgress('microsoft'));
      
      final result = await _authService.signInWithMicrosoft();
      
      if (result.success && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(AuthError(message: result.errorMessage ?? 'Microsoft login failed'));
      }
    } catch (e) {
      emit(AuthError(message: 'Microsoft login failed: ${e.toString()}'));
    }
  }

  /// Handle logout
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLogoutInProgress());
      
      await _authService.signOut();
      
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Logout failed: ${e.toString()}'));
      // Still emit unauthenticated state even if logout fails
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle token refresh
  Future<void> _onTokenRefreshRequested(
    AuthTokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthTokenRefreshing());
      
      final refreshSuccess = await _authService.refreshAuthentication();
      
      if (refreshSuccess && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: 'Token refresh failed: ${e.toString()}'));
      emit(const AuthUnauthenticated());
    }
  }

  /// Handle external authentication state changes
  Future<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (event.isAuthenticated && _authService.currentUser != null) {
        emit(AuthAuthenticated(_authService.currentUser!));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: 'Authentication state change failed: ${e.toString()}'));
    }
  }

  /// Get current authenticated user
  AuthUser? get currentUser => _authService.currentUser;

  /// Check if user is currently authenticated
  bool get isAuthenticated => state is AuthAuthenticated;

  /// Get user role if authenticated
  String? get userRole => currentUser?.role;

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}