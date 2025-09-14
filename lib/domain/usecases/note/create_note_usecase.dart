import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

/// Use case for creating a new note
/// Encapsulates the business logic for note creation
class CreateNoteUseCase {
  const CreateNoteUseCase(this._repository);

  final NoteRepository _repository;

  /// Execute create note use case
  Future<Either<Failure, NoteEntity>> call(CreateNoteParams params) async {
    // Validate input
    if (params.title.trim().isEmpty) {
      return left(InputFailure(errorMessage: 'Not başlığı boş olamaz'));
    }
    
    if (params.content.trim().isEmpty) {
      return left(InputFailure(errorMessage: 'Not içeriği boş olamaz'));
    }

    return await _repository.createNote(
      title: params.title.trim(),
      content: params.content.trim(),
      isFavorite: params.isFavorite,
    );
  }
}

/// Parameters for create note use case
class CreateNoteParams extends Equatable {
  const CreateNoteParams({
    required this.title,
    required this.content,
    this.isFavorite = false,
  });

  final String title;
  final String content;
  final bool isFavorite;

  @override
  List<Object> get props => [title, content, isFavorite];
}

/// Input validation failure
class InputFailure extends Failure {
  InputFailure({required super.errorMessage});
}
