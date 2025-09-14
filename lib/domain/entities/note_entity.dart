import 'package:equatable/equatable.dart';

/// Pure domain entity for Note
/// Contains only business logic relevant properties
class NoteEntity extends Equatable {
  const NoteEntity({
    this.id,
    required this.title,
    required this.content,
    this.isFavorite = false,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String title;
  final String content;
  final bool isFavorite;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        isFavorite,
        userId,
        createdAt,
        updatedAt,
      ];

  NoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    bool? isFavorite,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
