import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class UpdateNoteUseCase {
  const UpdateNoteUseCase(this._repository);

  final NoteRepository _repository;

  Future<Either<Failure, NoteEntity>> call(NoteEntity note) async {
    if (note.id == null || note.id!.isEmpty) {
      return const Left(InputFailure('Note ID is required for update'));
    }

    if (note.title.trim().isEmpty) {
      return const Left(InputFailure('Note title cannot be empty'));
    }

    if (note.content.trim().isEmpty) {
      return const Left(InputFailure('Note content cannot be empty'));
    }

    return _repository.updateNote(note: note);
  }
}

class InputFailure extends Failure {
  const InputFailure(String message) : super(errorMessage: message);
}
