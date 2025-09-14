import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_note_app/domain/entities/user_entity.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data Transfer Object for User
/// Used for API communication and data persistence
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? email,
    String? username,
    @JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,
    @JsonKey(name: 'updated_at', includeIfNull: false) DateTime? updatedAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert data model to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      email: email ?? '',
      username: username,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
    );
  }

  /// Create data model from domain entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
