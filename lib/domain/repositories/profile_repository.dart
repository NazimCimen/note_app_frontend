import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity?>> getUser();
}
