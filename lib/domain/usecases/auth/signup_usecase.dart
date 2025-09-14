import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';
import 'package:flutter_note_app/domain/repositories/user_repository.dart';

/// Use case for user signup functionality
/// Encapsulates the business logic for signup operation
class SignupUseCase {
  const SignupUseCase(this._authRepository, this._userRepository);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  /// Execute signup use case
  Future<Either<Failure, void>> call(SignupParams params) async {
    // First, create auth account
    final signupResult = await _authRepository.signup(
      fullName: params.fullName,
      phone: params.phone,
      email: params.email,
      password: params.password,
    );

    return signupResult.fold(
      (failure) => Left(failure),
      (userEntity) async {
        // Then, create user profile
        final createUserResult = await _userRepository.createUser(user: userEntity);
        return createUserResult.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
        );
      },
    );
  }
}

/// Parameters for signup use case
class SignupParams extends Equatable {
  const SignupParams({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String phone;
  final String email;
  final String password;

  @override
  List<Object> get props => [fullName, phone, email, password];
}
