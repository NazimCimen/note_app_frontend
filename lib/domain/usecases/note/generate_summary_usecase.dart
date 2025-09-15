import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class GenerateSummaryUseCase {
  const GenerateSummaryUseCase(this._repository);

  final NoteRepository _repository;

  Future<Either<Failure, String>> call(String content, String locale) async {
    if (content.trim().isEmpty) {
      return const Left(InputFailure('İçerik boş olamaz'));
    }

    if (content.trim().length < 100) {
      return const Left(InputFailure('Özet üretmek için en az 100 karakter gerekli'));
    }

    return _repository.generateSummary(content, locale);
  }
}

class InputFailure extends Failure {
  const InputFailure(String message) : super(errorMessage: message);

  List<Object?> get props => [errorMessage];
}