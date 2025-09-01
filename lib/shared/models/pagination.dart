import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'pagination.g.dart';

/// Pagination model for handling paginated data
@JsonSerializable()
class Pagination extends Equatable {
  @JsonKey(name: 'current_page')
  final int currentPage;
  
  @JsonKey(name: 'per_page')
  final int perPage;
  
  @JsonKey(name: 'total_items')
  final int totalItems;
  
  @JsonKey(name: 'total_pages')
  final int totalPages;
  
  @JsonKey(name: 'has_next_page')
  final bool hasNextPage;
  
  @JsonKey(name: 'has_previous_page')
  final bool hasPreviousPage;
  
  @JsonKey(name: 'next_page')
  final int? nextPage;
  
  @JsonKey(name: 'previous_page')
  final int? previousPage;

  const Pagination({
    required this.currentPage,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.nextPage,
    this.previousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  /// Create pagination for first page
  factory Pagination.firstPage({
    required int perPage,
    required int totalItems,
  }) {
    final totalPages = (totalItems / perPage).ceil();
    return Pagination(
      currentPage: 1,
      perPage: perPage,
      totalItems: totalItems,
      totalPages: totalPages,
      hasNextPage: totalPages > 1,
      hasPreviousPage: false,
      nextPage: totalPages > 1 ? 2 : null,
      previousPage: null,
    );
  }

  /// Create empty pagination
  factory Pagination.empty() {
    return const Pagination(
      currentPage: 1,
      perPage: 10,
      totalItems: 0,
      totalPages: 0,
      hasNextPage: false,
      hasPreviousPage: false,
      nextPage: null,
      previousPage: null,
    );
  }

  /// Calculate start index for current page
  int get startIndex => (currentPage - 1) * perPage + 1;

  /// Calculate end index for current page
  int get endIndex {
    final calculated = currentPage * perPage;
    return calculated > totalItems ? totalItems : calculated;
  }

  /// Check if this is the first page
  bool get isFirstPage => currentPage == 1;

  /// Check if this is the last page
  bool get isLastPage => currentPage == totalPages;

  /// Get page range for pagination display
  List<int> getPageRange({int maxPages = 5}) {
    final pages = <int>[];
    final half = (maxPages / 2).floor();
    
    int start = currentPage - half;
    int end = currentPage + half;
    
    if (start < 1) {
      start = 1;
      end = start + maxPages - 1;
    }
    
    if (end > totalPages) {
      end = totalPages;
      start = end - maxPages + 1;
    }
    
    if (start < 1) start = 1;
    
    for (int i = start; i <= end; i++) {
      pages.add(i);
    }
    
    return pages;
  }

  /// Copy with new values
  Pagination copyWith({
    int? currentPage,
    int? perPage,
    int? totalItems,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    int? nextPage,
    int? previousPage,
  }) {
    return Pagination(
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        perPage,
        totalItems,
        totalPages,
        hasNextPage,
        hasPreviousPage,
        nextPage,
        previousPage,
      ];

  @override
  String toString() {
    return 'Pagination(currentPage: $currentPage, perPage: $perPage, totalItems: $totalItems, totalPages: $totalPages)';
  }
}