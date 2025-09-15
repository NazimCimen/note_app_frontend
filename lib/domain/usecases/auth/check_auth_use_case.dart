import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';

class CheckAuthUseCase {
  final AuthRepository _authRepository;

  CheckAuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> call() async {
    return _authRepository.hasValidTokens();
  }
}
