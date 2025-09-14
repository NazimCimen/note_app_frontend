import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

/// UseCase for getting all notes for current user
/// Handles business logic for retrieving notes
class GetNotesUseCase {
  final NoteRepository _noteRepository;

  GetNotesUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  /// Execute the use case to get all notes
  /// filterBy: 'all' or 'favorites'
  /// sortBy: 'newest' or 'oldest'
  /// searchIn: 'both', 'title', or 'content'
  Future<Either<Failure, List<NoteEntity>>> call({
    String? search,
    String? searchIn, 
    String? filterBy, 
    String? sortBy, 
    int page = 1,
    int perPage = 10, 
  }) async {
    return  _noteRepository.getNotes(
      search: search,
      searchIn: searchIn,
      filterBy: filterBy,
      sortBy: sortBy,
      page: page,
      perPage: perPage,
    );
  }

  /// Get notes with optional filtering
  Future<Either<Failure, List<NoteEntity>>> getFilteredNotes({
    bool? isFavorite,
    String? searchQuery,
  }) async {
    final result = await _noteRepository.getNotes();
    
    return result.fold(
      (failure) => Left(failure),
      (notes) {
        List<NoteEntity> filteredNotes = notes;

        // Filter by favorite status
        if (isFavorite != null) {
          filteredNotes = filteredNotes
              .where((note) => note.isFavorite == isFavorite)
              .toList();
        }

        // Filter by search query
        if (searchQuery != null && searchQuery.isNotEmpty) {
          final query = searchQuery.toLowerCase();
          filteredNotes = filteredNotes
              .where((note) =>
                  note.title.toLowerCase().contains(query) ||
                  note.content.toLowerCase().contains(query))
              .toList();
        }

        // Sort by updated date (newest first)
        filteredNotes.sort((a, b) {
          if (a.updatedAt == null && b.updatedAt == null) return 0;
          if (a.updatedAt == null) return 1;
          if (b.updatedAt == null) return -1;
          return b.updatedAt!.compareTo(a.updatedAt!);
        });

        return Right(filteredNotes);
      },
    );
  }
}
