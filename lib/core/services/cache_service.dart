import 'dart:convert';
import '../constants/storage_constants.dart';
import 'local_storage_service.dart';

/// Cache service for managing temporary data storage
/// Provides efficient caching with expiration and size management
abstract class CacheService {
  // Basic cache operations
  Future<bool> put(String key, dynamic value, {Duration? expiry});
  Future<T?> get<T>(String key);
  Future<bool> remove(String key);
  Future<bool> clear();
  
  // Cache management
  Future<bool> exists(String key);
  Future<bool> isExpired(String key);
  Future<void> cleanExpired();
  Future<int> size();
  Future<List<String>> keys();
  
  // Typed operations
  Future<bool> putString(String key, String value, {Duration? expiry});
  Future<bool> putInt(String key, int value, {Duration? expiry});
  Future<bool> putDouble(String key, double value, {Duration? expiry});
  Future<bool> putBool(String key, bool value, {Duration? expiry});
  Future<bool> putList(String key, List<dynamic> value, {Duration? expiry});
  Future<bool> putMap(String key, Map<String, dynamic> value, {Duration? expiry});
}

class CacheServiceImpl implements CacheService {
  final LocalStorageService _storage;
  static const String _cachePrefix = 'cache_';
  static const String _expiryPrefix = 'expiry_';
  
  CacheServiceImpl(this._storage);
  
  @override
  Future<bool> put(String key, dynamic value, {Duration? expiry}) async {
    try {
      final cacheKey = _getCacheKey(key);
      final expiryKey = _getExpiryKey(key);
      
      // Serialize the value
      String serializedValue;
      if (value is String) {
        serializedValue = value;
      } else {
        serializedValue = json.encode(value);
      }
      
      // Store the value
      final storeResult = await _storage.setString(cacheKey, serializedValue);
      
      // Store expiry time if provided
      if (expiry != null) {
        final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;
        await _storage.setInt(expiryKey, expiryTime);
      }
      
      return storeResult;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<T?> get<T>(String key) async {
    try {
      final cacheKey = _getCacheKey(key);
      
      // Check if cache exists
      if (!await exists(key)) {
        return null;
      }
      
      // Check if cache is expired
      if (await isExpired(key)) {
        await remove(key);
        return null;
      }
      
      // Get the cached value
      final serializedValue = await _storage.getString(cacheKey);
      if (serializedValue == null) {
        return null;
      }
      
      // Deserialize based on type
      if (T == String) {
        return serializedValue as T;
      } else {
        final decodedValue = json.decode(serializedValue);
        return decodedValue as T;
      }
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<bool> remove(String key) async {
    final cacheKey = _getCacheKey(key);
    final expiryKey = _getExpiryKey(key);
    
    final results = await Future.wait([
      _storage.remove(cacheKey),
      _storage.remove(expiryKey),
    ]);
    
    return results.every((result) => result);
  }
  
  @override
  Future<bool> clear() async {
    final allKeys = await _storage.getKeys();
    final cacheKeys = allKeys.where((key) => 
        key.startsWith(_cachePrefix) || key.startsWith(_expiryPrefix));
    
    final removeResults = await Future.wait(
      cacheKeys.map((key) => _storage.remove(key)),
    );
    
    return removeResults.every((result) => result);
  }
  
  @override
  Future<bool> exists(String key) async {
    final cacheKey = _getCacheKey(key);
    return await _storage.containsKey(cacheKey);
  }
  
  @override
  Future<bool> isExpired(String key) async {
    final expiryKey = _getExpiryKey(key);
    final expiryTime = await _storage.getInt(expiryKey);
    
    if (expiryTime == null) {
      return false; // No expiry set, never expires
    }
    
    return DateTime.now().millisecondsSinceEpoch > expiryTime;
  }
  
  @override
  Future<void> cleanExpired() async {
    final allKeys = await keys();
    
    for (final key in allKeys) {
      if (await isExpired(key)) {
        await remove(key);
      }
    }
  }
  
  @override
  Future<int> size() async {
    final allKeys = await _storage.getKeys();
    return allKeys.where((key) => key.startsWith(_cachePrefix)).length;
  }
  
  @override
  Future<List<String>> keys() async {
    final allKeys = await _storage.getKeys();
    return allKeys
        .where((key) => key.startsWith(_cachePrefix))
        .map((key) => key.substring(_cachePrefix.length))
        .toList();
  }
  
  @override
  Future<bool> putString(String key, String value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  @override
  Future<bool> putInt(String key, int value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  @override
  Future<bool> putDouble(String key, double value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  @override
  Future<bool> putBool(String key, bool value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  @override
  Future<bool> putList(String key, List<dynamic> value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  @override
  Future<bool> putMap(String key, Map<String, dynamic> value, {Duration? expiry}) async {
    return await put(key, value, expiry: expiry);
  }
  
  /// Cache commonly used data with default expiry times
  Future<bool> cacheStudents(List<Map<String, dynamic>> students) async {
    return await putList(
      StorageConstants.cacheStudents,
      students,
      expiry: const Duration(hours: StorageConstants.mediumCacheExpiry),
    );
  }
  
  Future<bool> cacheTeachers(List<Map<String, dynamic>> teachers) async {
    return await putList(
      StorageConstants.cacheTeachers,
      teachers,
      expiry: const Duration(hours: StorageConstants.mediumCacheExpiry),
    );
  }
  
  Future<bool> cacheClasses(List<Map<String, dynamic>> classes) async {
    return await putList(
      StorageConstants.cacheClasses,
      classes,
      expiry: const Duration(hours: StorageConstants.longCacheExpiry),
    );
  }
  
  Future<bool> cacheAnnouncements(List<Map<String, dynamic>> announcements) async {
    return await putList(
      StorageConstants.cacheAnnouncements,
      announcements,
      expiry: const Duration(hours: StorageConstants.shortCacheExpiry),
    );
  }
  
  Future<bool> cacheDashboard(Map<String, dynamic> dashboard) async {
    return await putMap(
      StorageConstants.keyCachedDashboard,
      dashboard,
      expiry: const Duration(hours: StorageConstants.shortCacheExpiry),
    );
  }
  
  /// Get cached data
  Future<List<Map<String, dynamic>>?> getCachedStudents() async {
    final cached = await get<List<dynamic>>(StorageConstants.cacheStudents);
    return cached?.cast<Map<String, dynamic>>();
  }
  
  Future<List<Map<String, dynamic>>?> getCachedTeachers() async {
    final cached = await get<List<dynamic>>(StorageConstants.cacheTeachers);
    return cached?.cast<Map<String, dynamic>>();
  }
  
  Future<List<Map<String, dynamic>>?> getCachedClasses() async {
    final cached = await get<List<dynamic>>(StorageConstants.cacheClasses);
    return cached?.cast<Map<String, dynamic>>();
  }
  
  Future<List<Map<String, dynamic>>?> getCachedAnnouncements() async {
    final cached = await get<List<dynamic>>(StorageConstants.cacheAnnouncements);
    return cached?.cast<Map<String, dynamic>>();
  }
  
  Future<Map<String, dynamic>?> getCachedDashboard() async {
    return await get<Map<String, dynamic>>(StorageConstants.keyCachedDashboard);
  }
  
  /// Helper methods
  String _getCacheKey(String key) => '$_cachePrefix$key';
  String _getExpiryKey(String key) => '$_expiryPrefix$key';
}