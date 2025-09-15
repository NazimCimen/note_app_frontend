import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
part 'note_model.freezed.dart';
part 'note_model.g.dart';

/// Data Transfer Object for Note
/// Used for API communication and data persistence
@freezed
class NoteModel with _$NoteModel {
  const factory NoteModel({
    String? id,
    String? title,
    String? content,
    @JsonKey(name: 'is_favorite') bool? isFavorite,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? summary,
    String? keywords,
  }) = _NoteModel;

  const NoteModel._();

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  /// Convert data model to domain entity
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title ?? '',
      content: content ?? '',
      isFavorite: isFavorite ?? false,
      userId: userId,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      summary: summary,
      keywords: keywords,
    );
  }

  /// Create data model from domain entity
  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      isFavorite: entity.isFavorite,
      userId: entity.userId,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
      summary: entity.summary,
      keywords: entity.keywords,
    );
  }

  /// Create request body for API
  Map<String, dynamic> toCreateRequest() {
    final request = <String, dynamic>{};
    
    // Only include non-null fields in the request
    if (title != null) request['title'] = title;
    if (content != null) request['content'] = content;
    if (isFavorite != null) request['is_favorite'] = isFavorite;
    if (summary != null) request['summary'] = summary;
    if (keywords != null) request['keywords'] = keywords;
    
    return request;
  }
}
