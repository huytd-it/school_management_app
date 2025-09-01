import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'filter_model.g.dart';

/// Generic filter model for data filtering and searching
@JsonSerializable()
class FilterModel extends Equatable {
  final String? searchQuery;
  final Map<String, dynamic> filters;
  final String? sortBy;
  final SortOrder? sortOrder;
  final int page;
  final int perPage;
  final DateRange? dateRange;

  const FilterModel({
    this.searchQuery,
    this.filters = const {},
    this.sortBy,
    this.sortOrder,
    this.page = 1,
    this.perPage = 10,
    this.dateRange,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);

  /// Create empty filter
  factory FilterModel.empty() {
    return const FilterModel();
  }

  /// Create search filter
  factory FilterModel.search(String query) {
    return FilterModel(searchQuery: query);
  }

  /// Create sort filter
  factory FilterModel.sort(String sortBy, SortOrder sortOrder) {
    return FilterModel(sortBy: sortBy, sortOrder: sortOrder);
  }

  /// Copy with new values
  FilterModel copyWith({
    String? searchQuery,
    Map<String, dynamic>? filters,
    String? sortBy,
    SortOrder? sortOrder,
    int? page,
    int? perPage,
    DateRange? dateRange,
  }) {
    return FilterModel(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  /// Add filter
  FilterModel addFilter(String key, dynamic value) {
    final newFilters = Map<String, dynamic>.from(filters);
    newFilters[key] = value;
    return copyWith(filters: newFilters);
  }

  /// Remove filter
  FilterModel removeFilter(String key) {
    final newFilters = Map<String, dynamic>.from(filters);
    newFilters.remove(key);
    return copyWith(filters: newFilters);
  }

  /// Clear all filters
  FilterModel clearFilters() {
    return copyWith(
      filters: {},
      searchQuery: null,
      sortBy: null,
      sortOrder: null,
      dateRange: null,
    );
  }

  /// Check if has active filters
  bool get hasActiveFilters {
    return searchQuery != null ||
        filters.isNotEmpty ||
        sortBy != null ||
        dateRange != null;
  }

  /// Convert to query parameters
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      params['search'] = searchQuery;
    }

    if (sortBy != null) {
      params['sort_by'] = sortBy;
      if (sortOrder != null) {
        params['sort_order'] = sortOrder!.name;
      }
    }

    if (dateRange != null) {
      params['start_date'] = dateRange!.startDate.toIso8601String();
      params['end_date'] = dateRange!.endDate.toIso8601String();
    }

    // Add custom filters
    filters.forEach((key, value) {
      params[key] = value;
    });

    return params;
  }

  @override
  List<Object?> get props => [
        searchQuery,
        filters,
        sortBy,
        sortOrder,
        page,
        perPage,
        dateRange,
      ];
}

/// Sort order enumeration
enum SortOrder {
  @JsonValue('asc')
  ascending,
  @JsonValue('desc')
  descending,
}

extension SortOrderExtension on SortOrder {
  String get name {
    switch (this) {
      case SortOrder.ascending:
        return 'asc';
      case SortOrder.descending:
        return 'desc';
    }
  }
}

/// Date range model for filtering by dates
@JsonSerializable()
class DateRange extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const DateRange({
    required this.startDate,
    required this.endDate,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);

  Map<String, dynamic> toJson() => _$DateRangeToJson(this);

  /// Create date range for today
  factory DateRange.today() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return DateRange(startDate: startOfDay, endDate: endOfDay);
  }

  /// Create date range for this week
  factory DateRange.thisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateRange(
      startDate: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      endDate: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59),
    );
  }

  /// Create date range for this month
  factory DateRange.thisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    return DateRange(startDate: startOfMonth, endDate: endOfMonth);
  }

  /// Create date range for this year
  factory DateRange.thisYear() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31, 23, 59, 59);
    return DateRange(startDate: startOfYear, endDate: endOfYear);
  }

  /// Get duration in days
  int get durationInDays {
    return endDate.difference(startDate).inDays;
  }

  /// Check if date is in range
  bool contains(DateTime date) {
    return date.isAfter(startDate) && date.isBefore(endDate) ||
        date.isAtSameMomentAs(startDate) ||
        date.isAtSameMomentAs(endDate);
  }

  @override
  List<Object?> get props => [startDate, endDate];

  @override
  String toString() => 'DateRange(${startDate.toIso8601String()} - ${endDate.toIso8601String()})';
}