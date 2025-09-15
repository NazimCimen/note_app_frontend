import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';

/// Domain layer repository interface for note operations
/// Defines contracts for note-related operations
abstract class NoteRepository {
  /// Create a new note
  Future<Either<Failure, NoteEntity>> createNote({required NoteEntity note});

  /// Get all notes for current user with optional pagination, search, filtering and sorting
  /// filterBy: 'all' or 'favorites'
  /// sortBy: 'newest' or 'oldest'
  /// searchIn: 'both', 'title', or 'content'
  Future<Either<Failure, List<NoteEntity>>> getNotes({
    String? search,
    String? searchIn,
    String? filterBy,
    String? sortBy,
    int page = 1,
    int perPage = 10,
  });

  /// Get a specific note by id
  Future<Either<Failure, NoteEntity>> getNoteById({required String noteId});

  /// Update an existing note
  Future<Either<Failure, NoteEntity>> updateNote({required NoteEntity note});

  /// Delete a note
  Future<Either<Failure, void>> deleteNote({required String noteId});

  /// Toggle favorite status
  Future<Either<Failure, NoteEntity>> toggleFavorite({
    required NoteEntity note,
  });

  /// Generate keywords for a note
  Future<Either<Failure, String>> generateKeywords(String content, String locale);

  /// Generate summary for a note
  Future<Either<Failure, String>> generateSummary(String content, String locale);
}
