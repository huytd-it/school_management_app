import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'api_response.g.dart';

/// Generic API response wrapper
/// Provides consistent structure for all API responses
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, dynamic>? metadata;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
    this.statusCode,
    this.metadata,
  });

  /// Factory constructor for successful responses
  factory ApiResponse.success({
    required T data,
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  /// Factory constructor for error responses
  factory ApiResponse.error({
    required String error,
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse<T>(
      success: false,
      error: error,
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  /// Create from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  /// Convert to JSON
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  /// Check if response has data
  bool get hasData => data != null;

  /// Check if response has error
  bool get hasError => error != null;

  /// Get data or throw exception
  T get dataOrThrow {
    if (success && data != null) {
      return data!;
    }
    throw Exception(error ?? 'Unknown error occurred');
  }

  @override
  List<Object?> get props => [success, message, data, error, statusCode, metadata];

  @override
  String toString() {
    return 'ApiResponse{success: $success, message: $message, data: $data, error: $error, statusCode: $statusCode}';
  }
}

/// Paginated API response wrapper
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final Pagination pagination;
  final bool success;
  final String? message;

  const PaginatedResponse({
    required this.data,
    required this.pagination,
    required this.success,
    this.message,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [data, pagination, success, message];
}

/// Pagination metadata for paginated responses
@JsonSerializable()
class Pagination extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        totalPages,
        totalItems,
        itemsPerPage,
        hasNextPage,
        hasPreviousPage,
      ];
}