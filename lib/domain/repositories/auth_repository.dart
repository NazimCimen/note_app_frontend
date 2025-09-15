import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/utils/params/login_params.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';

/// Domain layer repository interface for authentication
/// Defines contracts for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, void>> login({
    required AuthParams loginParams,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signup({
    required AuthParams authParams,
  });


  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Refresh access token using refresh token
  Future<Either<Failure, void>> refreshToken();

  /// Check if user has valid tokens
  Future<Either<Failure, bool>> hasValidTokens();

  /// Get current access token
  Future<Either<Failure, String?>> getAccessToken();
}
