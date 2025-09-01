import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Network information service to check connectivity status
/// Provides methods to check internet connection and network type
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<List<ConnectivityResult>> get connectionType;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
  Future<bool> get hasInternetAccess;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  
  NetworkInfoImpl(this._connectivity);
  
  @override
  Future<bool> get isConnected async {
    final connectivityResults = await _connectivity.checkConnectivity();
    return !connectivityResults.contains(ConnectivityResult.none) && connectivityResults.isNotEmpty;
  }
  
  @override
  Future<List<ConnectivityResult>> get connectionType async {
    return await _connectivity.checkConnectivity();
  }
  
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }
  
  @override
  Future<bool> get hasInternetAccess async {
    // Check if device is connected to network
    if (!await isConnected) {
      return false;
    }
    
    // Try to reach a reliable host to verify internet access
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
  
  /// Check if connected to WiFi
  Future<bool> get isConnectedToWiFi async {
    final connectivityResults = await connectionType;
    return connectivityResults.contains(ConnectivityResult.wifi);
  }
  
  /// Check if connected to mobile data
  Future<bool> get isConnectedToMobile async {
    final connectivityResults = await connectionType;
    return connectivityResults.contains(ConnectivityResult.mobile);
  }
  
  /// Check if connected to ethernet
  Future<bool> get isConnectedToEthernet async {
    final connectivityResults = await connectionType;
    return connectivityResults.contains(ConnectivityResult.ethernet);
  }
  
  /// Get connection type as string
  Future<String> get connectionTypeString async {
    final connectivityResults = await connectionType;
    
    if (connectivityResults.isEmpty || connectivityResults.contains(ConnectivityResult.none)) {
      return 'No Connection';
    }
    
    // Return the first available connection type
    final primaryConnection = connectivityResults.first;
    switch (primaryConnection) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
        return 'No Connection';
    }
  }
}