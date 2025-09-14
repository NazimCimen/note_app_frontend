import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';

/// Use case for user login functionality
/// Encapsulates the business logic for login operation
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// Execute login use case
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for login use case
class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
