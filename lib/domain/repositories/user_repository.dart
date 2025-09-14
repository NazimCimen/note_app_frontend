import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';

/// Domain layer repository interface for user operations
/// Defines contracts for user-related operations
abstract class UserRepository {
  /// Create a new user in the system
  Future<Either<Failure, void>> createUser({required UserEntity user});

  /// Get current user information
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Update user information
  Future<Either<Failure, UserEntity>> updateUser({required UserEntity user});

  /// Delete user account
  Future<Either<Failure, void>> deleteUser({required String userId});
}
