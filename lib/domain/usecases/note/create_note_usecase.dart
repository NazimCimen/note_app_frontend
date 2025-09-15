import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

/// Use case for creating a new note
/// Encapsulates the business logic for note creation
class CreateNoteUseCase {
  const CreateNoteUseCase(this._repository);

  final NoteRepository _repository;

  /// Execute create note use case
  Future<Either<Failure, NoteEntity>> call(NoteEntity note) async {
    return _repository.createNote(note: note);
  }
}

