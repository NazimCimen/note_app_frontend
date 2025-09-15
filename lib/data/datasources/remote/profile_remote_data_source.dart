import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/data/models/user_model.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract user service for data layer
abstract class ProfileRemoteDataSource {
  /// Create user
  Future<Either<Failure, void>> createUser({required UserModel user});

  /// Get user
  Future<Either<Failure, UserModel?>> getUser();

  /// Update user
  Future<Either<Failure, UserModel>> updateUser({required UserModel user});

  /// Delete user
  Future<Either<Failure, void>> deleteUser({required String userId});
}

/// Supabase implementation of user service
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient _supabase;
  ProfileRemoteDataSourceImpl() : _supabase = Supabase.instance.client;

  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return right(null);

      final response = await _supabase
          .from('user')
          .select()
          .eq('id', user.id)
          .single();

      final userModel = UserModel.fromJson(response);
      return right(userModel);
    } catch (e) {
      if (e is PostgrestException) {
        return left(ServerFailure(errorMessage: e.code.toString()));
      }
      return left(ServerFailure(errorMessage: 'Failed to get user'));
    }
  }

  @override
  Future<Either<Failure, void>> createUser({required UserModel user}) async {
    try {
      final response = await _supabase
          .from('user')
          .insert(user.toJson())
          .select();
      if (response.isNotEmpty) return right(null);
      return left(ServerFailure(errorMessage: 'User creation failed'));
    } catch (e) {
      if (e is PostgrestException) {
        return left(ServerFailure(errorMessage: e.code.toString()));
      }
      return left(ServerFailure(errorMessage: 'User creation failed'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser({required UserModel user}) async {
    try {
      final response = await _supabase
          .from('user')
          .update(user.toJson())
          .eq('id', user.id!)
          .select()
          .single();

      final updatedUser = UserModel.fromJson(response);
      return right(updatedUser);
    } catch (e) {
      if (e is PostgrestException) {
        return left(ServerFailure(errorMessage: e.code.toString()));
      }
      return left(ServerFailure(errorMessage: 'Failed to update user'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String userId}) async {
    try {
      await _supabase
          .from('user')
          .delete()
          .eq('id', userId);
      return right(null);
    } catch (e) {
      if (e is PostgrestException) {
        return left(ServerFailure(errorMessage: e.code.toString()));
      }
      return left(ServerFailure(errorMessage: 'Failed to delete user'));
    }
  }
}