import 'package:equatable/equatable.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Unified state for Home screen containing all necessary data
class HomeState extends Equatable {
  const HomeState({
    required this.paginationState,
    this.searchType = SearchType.both,
    this.searchQuery,
    this.filterBy = 'all',
    this.sortBy = 'newest',
    this.selectedFilter = 'Tümü',
    this.selectedSort = 'En Yeni',
  });

  final PagingState<int, NoteEntity> paginationState;
  final SearchType searchType;
  final String? searchQuery;
  final String filterBy;
  final String sortBy;
  final String selectedFilter;
  final String selectedSort;

  /// Create a copy of this state with updated values
  HomeState copyWith({
    PagingState<int, NoteEntity>? paginationState,
    SearchType? searchType,
    String? searchQuery,
    String? filterBy,
    String? sortBy,
    String? selectedFilter,
    String? selectedSort,
  }) {
    return HomeState(
      paginationState: paginationState ?? this.paginationState,
      searchType: searchType ?? this.searchType,
      searchQuery: searchQuery ?? this.searchQuery,
      filterBy: filterBy ?? this.filterBy,
      sortBy: sortBy ?? this.sortBy,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedSort: selectedSort ?? this.selectedSort,
    );
  }

  /// Reset pagination while keeping other state
  HomeState resetPagination() {
    return copyWith(paginationState: PagingState<int, NoteEntity>());
  }

  /// Reset all filters to default values
  HomeState resetFilters() {
    return copyWith(
      searchQuery: null,
      filterBy: 'all',
      sortBy: 'newest',
      selectedFilter: 'Tümü',
      selectedSort: 'En Yeni',
      paginationState: PagingState<int, NoteEntity>(),
    );
  }

  @override
  List<Object?> get props => [
    paginationState,
    searchType,
    searchQuery,
    filterBy,
    sortBy,
    selectedFilter,
    selectedSort,
  ];
}
