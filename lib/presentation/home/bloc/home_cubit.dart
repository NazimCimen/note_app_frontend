import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/usecases/note/get_notes_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/toggle_favorite_usecase.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_state.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Cubit for managing home screen state and business logic
class HomeCubit extends Cubit<HomeState> {
  final GetNotesUseCase _getNotesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  HomeCubit({
    required GetNotesUseCase getNotesUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  }) : _getNotesUseCase = getNotesUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       super(HomeState(paginationState: PagingState<int, NoteEntity>()));

  Future<void> fetchNextPage() async {
    if (state.paginationState.isLoading) return;

    emit(state.copyWith(
      paginationState: state.paginationState.copyWith(isLoading: true, error: null),
    ));

    final currentKeys = state.paginationState.keys ?? [];
    final newKey = currentKeys.isEmpty ? 1 : currentKeys.last + 1;

    final result = await _getNotesUseCase.call(
      page: newKey,
      perPage: HomeConstants.defaultPageSize,
      search: state.searchQuery,
      searchIn: state.searchType.value,
      filterBy: state.filterBy,
      sortBy: state.sortBy,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          paginationState: state.paginationState.copyWith(
            error: failure.errorMessage,
            isLoading: false,
          ),
        ));
      },
      (newNotes) {
        final isLastPage = newNotes.isEmpty || newNotes.length < HomeConstants.defaultPageSize;

        // If this is the first page (newKey == 1), replace pages instead of appending
        final updatedPages = newKey == 1
            ? [newNotes]
            : [...?state.paginationState.pages, newNotes];

        final updatedKeys = newKey == 1 ? [newKey] : [...?state.paginationState.keys, newKey];

        emit(state.copyWith(
          paginationState: state.paginationState.copyWith(
            pages: updatedPages,
            keys: updatedKeys,
            hasNextPage: !isLastPage,
            isLoading: false,
          ),
        ));
      },
    );
  }

  /// Refresh notes data by resetting pagination
  Future<void> refreshNotes() async {
    emit(state.resetFilters());
    await fetchNextPage();
  }

  /// Load initial notes (alias for fetchNextPage for first load)
  Future<void> loadNotes() async {
    emit(state.resetPagination());
    await fetchNextPage();
  }

  /// Update search query and refresh data
  Future<void> updateSearchQuery(String query) async {
    final searchQuery = query.isEmpty ? null : query;
    emit(state.copyWith(
      searchQuery: searchQuery,
      paginationState: PagingState<int, NoteEntity>(),
    ));
    await fetchNextPage();
  }

  /// Update search type and refresh data
  Future<void> updateSearchType(SearchType searchType) async {
    // Always emit to update UI, but only fetch data if there's a search query
    emit(state.copyWith(searchType: searchType));
    if (state.searchQuery != null) {
      emit(state.copyWith(
        searchType: searchType,
        paginationState: PagingState<int, NoteEntity>(),
      ));
      await fetchNextPage();
    }
  }

  /// Get current search type
  SearchType get currentSearchType => state.searchType;

  /// Update filter and refresh data
  Future<void> updateFilter(String filterBy) async {
    emit(state.copyWith(
      filterBy: filterBy,
      paginationState: PagingState<int, NoteEntity>(),
    ));
    await fetchNextPage();
  }

  /// Update filter from UI selection
  Future<void> selectFilter(String filter) async {
    final apiFilter = HomeConstants.getApiFilterFromUi(filter);
    emit(state.copyWith(
      selectedFilter: filter,
      filterBy: apiFilter,
      paginationState: PagingState<int, NoteEntity>(),
    ));
    await fetchNextPage();
  }

  /// Get current filter
  String get currentFilter => state.filterBy;

  /// Update sort and refresh data
  Future<void> updateSort(String sortBy) async {
    emit(state.copyWith(
      sortBy: sortBy,
      paginationState: PagingState<int, NoteEntity>(),
    ));
    await fetchNextPage();
  }

  /// Update sort from UI selection
  Future<void> selectSort(String sort) async {
    final apiSort = HomeConstants.getApiSortFromUi(sort);
    emit(state.copyWith(
      selectedSort: sort,
      sortBy: apiSort,
      paginationState: PagingState<int, NoteEntity>(),
    ));
    await fetchNextPage();
  }

  /// Get current sort
  String get currentSort => state.sortBy;

  // UI state getters
  String get selectedFilter => state.selectedFilter;
  String get selectedSort => state.selectedSort;
  List<String> get filterOptions => HomeConstants.filterOptions;
  List<String> get sortOptions => HomeConstants.sortOptions;

  /// Clear all filters and reset to defaults
  Future<void> clearFilters() async {
    emit(state.resetFilters());
    await fetchNextPage();
  }

  /// Toggle favorite status of a note in the current pages
  Future<void> toggleNoteFavorite(String noteId) async {
    final currentPages = state.paginationState.pages ?? [];
    if (currentPages.isEmpty) return;

    // Find and update the note in current pages
    final updatedPages = currentPages.map((List<NoteEntity> page) {
      return page.map((NoteEntity note) {
        if (note.id == noteId) {
          return note.copyWith(isFavorite: !note.isFavorite);
        }
        return note;
      }).toList();
    }).toList();

    emit(state.copyWith(
      paginationState: state.paginationState.copyWith(pages: updatedPages),
    ));

    // Update in database
    final allNotes = updatedPages.expand((List<NoteEntity> page) => page).toList();
    final updatedNote = allNotes.firstWhere((NoteEntity note) => note.id == noteId);
    await _toggleFavoriteUseCase.call(note: updatedNote);
  }
}
