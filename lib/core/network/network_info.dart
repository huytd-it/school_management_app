import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Network information service to check connectivity status
/// Provides methods to check internet connection and network type
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<ConnectivityResult> get connectionType;
  Stream<ConnectivityResult> get onConnectivityChanged;
  Future<bool> get hasInternetAccess;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  
  NetworkInfoImpl(this._connectivity);
  
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  
  @override
  Future<ConnectivityResult> get connectionType async {
    return await _connectivity.checkConnectivity();
  }
  
  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
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
    final connectivityResult = await connectionType;
    return connectivityResult == ConnectivityResult.wifi;
  }
  
  /// Check if connected to mobile data
  Future<bool> get isConnectedToMobile async {
    final connectivityResult = await connectionType;
    return connectivityResult == ConnectivityResult.mobile;
  }
  
  /// Check if connected to ethernet
  Future<bool> get isConnectedToEthernet async {
    final connectivityResult = await connectionType;
    return connectivityResult == ConnectivityResult.ethernet;
  }
  
  /// Get connection type as string
  Future<String> get connectionTypeString async {
    final connectivityResult = await connectionType;
    switch (connectivityResult) {
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