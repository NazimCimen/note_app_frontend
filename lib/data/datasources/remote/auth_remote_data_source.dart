import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/error/auth_error_handler.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/data/models/user_model.dart';
import 'package:flutter_note_app/data/datasources/local/auth_local_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract authentication service for data layer
abstract class AuthRemoteDataSource {
  /// Sign up with email and password
  Future<Either<Failure, UserModel>> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });

  /// Login with email and password
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  /// Logout
  Future<Either<Failure, void>> logout();

  /// Refresh access token using refresh token
  Future<Either<Failure, void>> refreshToken();
}

/// Supabase-backed implementation
final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required SupabaseClient supabase,
    required AuthLocalDataSource authLocalDataSource,
  }) : _supabase = supabase,
       _authLocalDataSource = authLocalDataSource;

  final SupabaseClient _supabase;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<Either<Failure, UserModel>> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'devcode://mail-verification',
      );
      if (response.user != null) {
        final userModel = UserModel(
          id: response.user!.id,
          email: email,
          username: fullName,
          createdAt: DateTime.now().toUtc(),
        );
        return right(userModel);
      }
      return left(
        ServerFailure(errorMessage: StringConstants.errorUnexpectedFailure),
      );
    } on AuthException catch (e) {
      return AuthErrorHandler.handleSignupAuthException(e);
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null && response.session?.accessToken != null) {
        await _authLocalDataSource.saveTokens(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken ?? '',
        );
        return right(null);
      }
      return left(
        ServerFailure(errorMessage: StringConstants.errorUnexpectedFailure),
      );
    } on AuthException catch (e) {
      return AuthErrorHandler.handleLoginAuthException(e);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _supabase.auth.signOut();
      await _authLocalDataSource.clearTokens();
      return right(null);
    } catch (e) {
      if (e is PostgrestException) {
        return left(ServerFailure(errorMessage: e.code.toString()));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      final response = await _supabase.auth.refreshSession();
      if (response.session?.accessToken != null) {
        await _authLocalDataSource.saveTokens(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken ?? '',
        );
        return right(null);
      }
      return left(
        ServerFailure(errorMessage: StringConstants.errorUnexpectedFailure),
      );
    } catch (e) {
      return left(
        ServerFailure(errorMessage: StringConstants.errorUnexpectedFailure),
      );
    }
  }
}
