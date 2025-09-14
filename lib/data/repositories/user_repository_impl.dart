import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/data/models/user_model.dart';
import 'package:flutter_note_app/data/datasources/remote/user_service.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  UserRepositoryImpl({required UserService userService})
    : _userService = userService;

  @override
  Future<Either<Failure, void>> createUser({required UserEntity user}) async {
    final userModel = UserModel.fromEntity(user);
    return _userService.createUser(user: userModel);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    final result = await _userService.getUser();
    
    return result.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel?.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({required UserEntity user}) async {
    final userModel = UserModel.fromEntity(user);
    final result = await _userService.updateUser(user: userModel);
    
    return result.fold(
      (failure) => Left(failure),
      (updatedUserModel) => Right(updatedUserModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String userId}) async {
    return _userService.deleteUser(userId: userId);
  }
}
