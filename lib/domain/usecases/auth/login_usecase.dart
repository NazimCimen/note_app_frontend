import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/utils/params/login_params.dart';
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';

/// Use case for user login functionality
/// Encapsulates the business logic for login operation
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// Execute login use case
  Future<Either<Failure, void>> call(AuthParams params) async {
    return _repository.login(loginParams: params);
  }
}
