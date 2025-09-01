// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) => FilterModel(
      searchQuery: json['searchQuery'] as String?,
      filters: json['filters'] as Map<String, dynamic>? ?? const {},
      sortBy: json['sortBy'] as String?,
      sortOrder: $enumDecodeNullable(_$SortOrderEnumMap, json['sortOrder']),
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['perPage'] as num?)?.toInt() ?? 10,
      dateRange: json['dateRange'] == null
          ? null
          : DateRange.fromJson(json['dateRange'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'filters': instance.filters,
      'sortBy': instance.sortBy,
      'sortOrder': _$SortOrderEnumMap[instance.sortOrder],
      'page': instance.page,
      'perPage': instance.perPage,
      'dateRange': instance.dateRange,
    };

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'asc',
  SortOrder.descending: 'desc',
};

DateRange _$DateRangeFromJson(Map<String, dynamic> json) => DateRange(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$DateRangeToJson(DateRange instance) => <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
