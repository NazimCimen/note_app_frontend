import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
import 'package:flutter_note_app/domain/repositories/profile_repository.dart';

class GetUserUseCase {
  final ProfileRepository repository;

  GetUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity?>> call() async {
    return  repository.getUser();
  }
}
