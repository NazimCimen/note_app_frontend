/// Enum for search type options
enum SearchType {
  title('title', 'Başlıkta Ara'),
  content('content', 'İçerikte Ara'),
  both('both', 'Her Yerde Ara');

  const SearchType(this.value, this.displayName);

  final String value;
  final String displayName;

  /// Get SearchType from string value
  static SearchType fromValue(String value) {
    return SearchType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => SearchType.both,
    );
  }
}
