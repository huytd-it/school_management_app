/// Storage Constants for the School ERP System
/// Contains all local storage related constants and keys
class StorageConstants {
  // SharedPreferences Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserProfile = 'user_profile';
  static const String keyUserRole = 'user_role';
  static const String keyUserPermissions = 'user_permissions';
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyLanguageCode = 'language_code';
  static const String keyThemeMode = 'theme_mode';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyAutoLogin = 'auto_login';
  static const String keyLastSyncTime = 'last_sync_time';
  static const String keyOfflineMode = 'offline_mode';
  static const String keyUserPreferences = 'user_preferences';
  static const String keyCachedDashboard = 'cached_dashboard';
  static const String keyRememberCredentials = 'remember_credentials';
  
  // Cache Keys
  static const String cacheStudents = 'cache_students';
  static const String cacheTeachers = 'cache_teachers';
  static const String cacheClasses = 'cache_classes';
  static const String cacheSubjects = 'cache_subjects';
  static const String cacheAnnouncements = 'cache_announcements';
  static const String cacheEvents = 'cache_events';
  static const String cacheNotifications = 'cache_notifications';
  static const String cacheAttendance = 'cache_attendance';
  static const String cacheGrades = 'cache_grades';
  static const String cacheFees = 'cache_fees';
  static const String cacheReports = 'cache_reports';
  
  // Database Tables (for local SQLite if needed)
  static const String tableUsers = 'users';
  static const String tableStudents = 'students';
  static const String tableTeachers = 'teachers';
  static const String tableClasses = 'classes';
  static const String tableSubjects = 'subjects';
  static const String tableAttendance = 'attendance';
  static const String tableGrades = 'grades';
  static const String tableFees = 'fees';
  static const String tablePayments = 'payments';
  static const String tableAnnouncements = 'announcements';
  static const String tableEvents = 'events';
  static const String tableNotifications = 'notifications';
  static const String tableMessages = 'messages';
  
  // File Storage Paths
  static const String documentsFolder = 'documents';
  static const String imagesFolder = 'images';
  static const String avatarsFolder = 'avatars';
  static const String reportsFolder = 'reports';
  static const String backupFolder = 'backup';
  static const String tempFolder = 'temp';
  static const String cacheFolder = 'cache';
  
  // Cache Expiration Times (in hours)
  static const int shortCacheExpiry = 1;      // 1 hour
  static const int mediumCacheExpiry = 6;     // 6 hours
  static const int longCacheExpiry = 24;      // 24 hours
  static const int extendedCacheExpiry = 168; // 1 week
  
  // File Size Limits (in bytes)
  static const int maxImageSize = 5 * 1024 * 1024;      // 5MB
  static const int maxDocumentSize = 10 * 1024 * 1024;  // 10MB
  static const int maxVideoSize = 50 * 1024 * 1024;     // 50MB
  
  // Security Keys
  static const String encryptionKey = 'encryption_key';
  static const String saltKey = 'salt_key';
  static const String ivKey = 'iv_key';
  
  // Default Values
  static const String defaultLanguage = 'en';
  static const String defaultTheme = 'light';
  static const bool defaultNotifications = true;
  static const bool defaultBiometric = false;
  static const bool defaultAutoLogin = false;
  static const bool defaultOfflineMode = false;
  
  // Sync Settings
  static const String syncFrequency = 'sync_frequency';
  static const String lastSyncTimestamp = 'last_sync_timestamp';
  static const String syncOnWifiOnly = 'sync_on_wifi_only';
  static const String autoSync = 'auto_sync';
  
  // App Settings
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';
  static const String deviceId = 'device_id';
  static const String installationId = 'installation_id';
  static const String fcmToken = 'fcm_token';
  
  // Feature Flags
  static const String featureOfflineMode = 'feature_offline_mode';
  static const String featureBiometric = 'feature_biometric';
  static const String featureDarkMode = 'feature_dark_mode';
  static const String featureNotifications = 'feature_notifications';
  static const String featureAnalytics = 'feature_analytics';
  
  // Privacy Settings
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String dataCollectionConsent = 'data_collection_consent';
  
  // UI Preferences
  static const String dashboardLayout = 'dashboard_layout';
  static const String listViewType = 'list_view_type';
  static const String dateFormat = 'date_format';
  static const String timeFormat = 'time_format';
  static const String numberFormat = 'number_format';
  
  // Security Settings
  static const String sessionTimeout = 'session_timeout';
  static const String lockAppOnBackground = 'lock_app_on_background';
  static const String requirePinForSensitiveActions = 'require_pin_for_sensitive_actions';
  
  // Cache Management
  static const String cacheSize = 'cache_size';
  static const String maxCacheSize = 'max_cache_size';
  static const String autoClearCache = 'auto_clear_cache';
  static const String cachePolicy = 'cache_policy';
}