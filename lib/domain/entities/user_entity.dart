import 'package:equatable/equatable.dart';

/// Pure domain entity for User
/// Contains only business logic relevant properties
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String? username;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, email, username, createdAt, updatedAt];

  UserEntity copyWith({
    String? id,
    String? email,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
