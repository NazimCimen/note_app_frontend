import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

/// UseCase for toggling favorite status of a note
/// Handles business logic for favorite/unfavorite operations
class ToggleFavoriteUseCase {
  final NoteRepository _noteRepository;

  ToggleFavoriteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  /// Execute the use case to toggle favorite status
  /// Returns Either<Failure, NoteEntity> with updated note
  Future<Either<Failure, NoteEntity>> call({
    required NoteEntity note,
  }) async {
    return _noteRepository.toggleFavorite(note: note);
  }
}
