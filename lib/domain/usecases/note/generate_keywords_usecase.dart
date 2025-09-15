import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class GenerateKeywordsUseCase {
  const GenerateKeywordsUseCase(this._repository);

  final NoteRepository _repository;

  Future<Either<Failure, String>> call(String content, String locale) async {
    if (content.trim().isEmpty) {
      return const Left(InputFailure('İçerik boş olamaz'));
    }

    if (content.trim().length < 50) {
      return const Left(InputFailure('Anahtar kelime üretmek için en az 50 karakter gerekli'));
    }

    return _repository.generateKeywords(content, locale);
  }
}

class InputFailure extends Failure {
  const InputFailure(String message) : super(errorMessage: message);

  List<Object?> get props => [errorMessage];
}