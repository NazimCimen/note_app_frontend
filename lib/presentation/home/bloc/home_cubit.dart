import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/usecases/note/get_notes_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/toggle_favorite_usecase.dart';
import 'package:flutter_note_app/presentation/home/bloc/search_type.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Cubit for managing home screen state and business logic using PagingState
class HomeCubit extends Cubit<PagingState<int, NoteEntity>> {
  final GetNotesUseCase _getNotesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  HomeCubit({
    required GetNotesUseCase getNotesUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  }) : _getNotesUseCase = getNotesUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       super(PagingState<int, NoteEntity>());

  String? _currentSearchQuery;
  SearchType _searchType = SearchType.both;
  String _filterBy = 'all'; // 'all', 'favorites'
  String _sortBy = 'newest'; // 'newest', 'oldest'
  
  // UI state for filter and sort options
  String _selectedFilter = 'Tümü';
  String _selectedSort = 'En Yeni';
  List<String> _filterOptions = ['Tümü', 'Favoriler'];
  List<String> _sortOptions = ['En Yeni', 'En Eski'];

  /// Fetch next page of notes for pagination
  Future<void> fetchNextPage() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    final currentKeys = state.keys ?? [];
    final newKey = currentKeys.isEmpty ? 1 : currentKeys.last + 1;

    final result = await _getNotesUseCase.call(
      page: newKey,
      perPage: 10,
      search: _currentSearchQuery,
      searchIn: _searchType.value,
      filterBy: _filterBy,
      sortBy: _sortBy, 
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.errorMessage,
          isLoading: false,
        ));
      },
      (newNotes) {
        final isLastPage = newNotes.isEmpty || newNotes.length < 10;

        emit(state.copyWith(
          pages: [...?state.pages, newNotes],
          keys: [...?state.keys, newKey],
          hasNextPage: !isLastPage,
          isLoading: false,
        ));
      },
    );
  }

  /// Refresh notes data by resetting pagination
  Future<void> refreshNotes() async {
    _currentSearchQuery = null;
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Load initial notes (alias for fetchNextPage for first load)
  Future<void> loadNotes() async {
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Update search query and refresh data
  Future<void> updateSearchQuery(String query) async {
    _currentSearchQuery = query.isEmpty ? null : query;
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Update search type and refresh data
  Future<void> updateSearchType(SearchType searchType) async {
    _searchType = searchType;
    if (_currentSearchQuery != null) {
      emit(PagingState<int, NoteEntity>());
      await fetchNextPage();
    }
  }

  /// Get current search type
  SearchType get currentSearchType => _searchType;

  /// Update filter and refresh data
  Future<void> updateFilter(String filterBy) async {
    _filterBy = filterBy;
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Update filter from UI selection
  Future<void> selectFilter(String filter) async {
    _selectedFilter = filter;
    _filterBy = filter == 'Favoriler' ? 'favorites' : 'all';
    
    // Reset pagination state and fetch new data
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Get current filter
  String get currentFilter => _filterBy;

  /// Update sort and refresh data
  Future<void> updateSort(String sortBy) async {
    _sortBy = sortBy;
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Update sort from UI selection
  Future<void> selectSort(String sort) async {
    _selectedSort = sort;
    _sortBy = sort == 'En Eski' ? 'oldest' : 'newest';
    
    // Reset pagination state and fetch new data
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Get current sort
  String get currentSort => _sortBy;
  
  // UI state getters
  String get selectedFilter => _selectedFilter;
  String get selectedSort => _selectedSort;
  List<String> get filterOptions => _filterOptions;
  List<String> get sortOptions => _sortOptions;

  /// Clear all filters and reset to defaults
  Future<void> clearFilters() async {
    _currentSearchQuery = null;
    _filterBy = 'all';
    _sortBy = 'newest';
    _selectedFilter = 'Tümü';
    _selectedSort = 'En Yeni';
    emit(PagingState<int, NoteEntity>());
    await fetchNextPage();
  }

  /// Toggle favorite status of a note in the current pages
  Future<void> toggleNoteFavorite(String noteId) async {
    final currentPages = state.pages ?? [];
    if (currentPages.isEmpty) return;

    // Find and update the note in current pages
    final updatedPages = currentPages.map((page) {
      return page.map((note) {
        if (note.id == noteId) {
          return note.copyWith(isFavorite: !note.isFavorite);
        }
        return note;
      }).toList();
    }).toList();

    emit(state.copyWith(pages: updatedPages));

    // Update in database
    final allNotes = updatedPages.expand((page) => page).toList();
    final updatedNote = allNotes.firstWhere((note) => note.id == noteId);
    await _toggleFavoriteUseCase.call(note: updatedNote);
  }
}