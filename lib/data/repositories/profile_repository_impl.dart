import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource userService;

  ProfileRepositoryImpl({required this.userService});

  @override
  Future<Either<Failure, UserEntity?>> getUser() async {
    final result = await userService.getUser();
    
    return result.fold(
      (failure) => left(failure),
      (userModel) => right(userModel?.toEntity()),
    );
  }
}
