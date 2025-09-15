import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/domain/repositories/auth_repository.dart';
import 'package:flutter_note_app/core/utils/params/login_params.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _service;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource service,
    required AuthLocalDataSource authLocalDataSource,
  }) : _service = service,
       _authLocalDataSource = authLocalDataSource;

  @override
  Future<Either<Failure, void>> login({required AuthParams loginParams}) async {
    return _service.login(authParams: loginParams);
  }

  @override
  Future<Either<Failure, UserEntity>> signup({
    required AuthParams authParams,
  }) async {
    final result = await _service.signup(authParams: authParams);

    return result.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return _service.logout();
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    return _service.refreshToken();
  }

  @override
  Future<Either<Failure, bool>> hasValidTokens() async {
    try {
      final hasTokens = await _authLocalDataSource.hasValidTokens();
      return Right(hasTokens);
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: 'Failed to check token validity: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> getAccessToken() async {
    try {
      final token = await _authLocalDataSource.getAccessToken();
      return Right(token);
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: 'Failed to get access token: $e'),
      );
    }
  }
}
