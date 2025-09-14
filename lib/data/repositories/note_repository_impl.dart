import 'package:dartz/dartz.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/data/models/note_model.dart';
import 'package:flutter_note_app/data/datasources/remote/note_remote_data_source.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource _noteService;

  NoteRepositoryImpl({required NoteRemoteDataSource noteService})
    : _noteService = noteService;

  @override
  Future<Either<Failure, NoteEntity>> createNote({
    required String title,
    required String content,
    bool isFavorite = false,
  }) async {
    final result = await _noteService.createNote(
      title: title,
      content: content,
      isFavorite: isFavorite,
    );

    return result.fold(
      (failure) => Left(failure),
      (noteModel) => Right(noteModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes({
    String? search,
    String? searchIn, // 'both', 'title', 'content'
    String? filterBy, // 'all', 'favorites'
    String? sortBy, // 'newest', 'oldest'
    int page = 1,
    int perPage = 10,
  }) async {
    final result = await _noteService.getNotes(
      search: search,
      searchIn: searchIn,
      filterBy: filterBy,
      sortBy: sortBy,
      page: page,
      perPage: perPage,
    );

    return result.fold(
      (failure) => Left(failure),
      (noteModels) =>
          Right(noteModels.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, NoteEntity>> getNoteById({
    required String noteId,
  }) async {
    final result = await _noteService.getNoteById(noteId: noteId);

    return result.fold(
      (failure) => Left(failure),
      (noteModel) => Right(noteModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, NoteEntity>> updateNote({
    required NoteEntity note,
  }) async {
    final noteModel = NoteModel.fromEntity(note);
    final result = await _noteService.updateNote(note: noteModel);

    return result.fold(
      (failure) => Left(failure),
      (updatedNoteModel) => Right(updatedNoteModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, void>> deleteNote({required String noteId}) async {
    return _noteService.deleteNote(noteId: noteId);
  }

  @override
  Future<Either<Failure, NoteEntity>> toggleFavorite({
    required NoteEntity note,
  }) async {
    final noteModel = NoteModel.fromEntity(note);
    final updateResult = await _noteService.updateNote(note: noteModel);

    return updateResult.fold(
      (failure) => Left(failure),
      (updatedNoteModel) => Right(updatedNoteModel.toEntity()),
    );
  }
}
