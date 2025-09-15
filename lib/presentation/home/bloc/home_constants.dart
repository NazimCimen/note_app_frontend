import 'package:flutter_note_app/core/config/localization/string_constants.dart';

/// Constants for Home screen state management
class HomeConstants {
  // API filter values
  static const String filterAll = 'all';
  static const String filterFavorites = 'favorites';

  // API sort values
  static const String sortNewest = 'newest';
  static const String sortOldest = 'oldest';

  // UI display values
  static String get uiFilterAll => StringConstants.homeFilterAll;
  static String get uiFilterFavorites => StringConstants.homeFilterFavorites;
  static String get uiSortNewest => StringConstants.homeSortNewest;
  static String get uiSortOldest => StringConstants.homeSortOldest;

  // Pagination
  static const int defaultPageSize = 10;

  // Filter options
  static List<String> get filterOptions => [uiFilterAll, uiFilterFavorites];

  // Sort options
  static List<String> get sortOptions => [uiSortNewest, uiSortOldest];

  // Helper methods
  static String getApiFilterFromUi(String uiFilter) {
    return uiFilter == uiFilterFavorites ? filterFavorites : filterAll;
  }

  static String getApiSortFromUi(String uiSort) {
    return uiSort == uiSortOldest ? sortOldest : sortNewest;
  }
}

/// Enum for search type options
enum SearchType {
  title('title'),
  content('content'),
  both('both');

  const SearchType(this.value);

  final String value;
  
  String get displayName {
    switch (this) {
      case SearchType.title:
        return StringConstants.homeSearchTitle;
      case SearchType.content:
        return StringConstants.homeSearchContent;
      case SearchType.both:
        return StringConstants.homeSearchBoth;
    }
  }

  /// Get SearchType from string value
  static SearchType fromValue(String value) {
    return SearchType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => SearchType.both,
    );
  }
}
