import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/error/dio_error_handler.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/data/models/note_model.dart';

/// Abstract note service for data layer
abstract class NoteRemoteDataSource {
  /// Create a new note
  Future<Either<Failure, NoteModel>> createNote({
    required String title,
    required String content,
    bool isFavorite = false,
  });

  /// Get all notes with optional pagination, search, filtering and sorting
  /// filterBy: 'all' or 'favorites'
  /// sortBy: 'newest' or 'oldest'
  /// searchIn: 'both', 'title', or 'content'
  Future<Either<Failure, List<NoteModel>>> getNotes({
    String? search,
    String? searchIn, 
    String? filterBy,
    String? sortBy, 
    int page = 1,
    int perPage = 10,
  });

  /// Get note by id
  Future<Either<Failure, NoteModel>> getNoteById({required String noteId});

  /// Update note
  Future<Either<Failure, NoteModel>> updateNote({required NoteModel note});

  /// Delete note
  Future<Either<Failure, void>> deleteNote({required String noteId});
}

/// HTTP implementation of note service
/// Uses DioClient with AuthInterceptor for automatic JWT token management
class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio _dio;

  NoteRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, NoteModel>> createNote({
    required String title,
    required String content,
    bool isFavorite = false,
  }) async {
    try {
      final requestData = {
        'title': title,
        'content': content,
        'is_favorite': isFavorite,
      };

      final response = await _dio.post<Map<String, dynamic>>(
        '/notes/',
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final noteModel = NoteModel.fromJson(response.data!);
        return right(noteModel);
      }

      return left(
        ServerFailure(errorMessage: StringConstants.noteCreateFailed),
      );
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }

  @override
  Future<Either<Failure, List<NoteModel>>> getNotes({
    String? search,
    String? searchIn,
    String? filterBy,
    String? sortBy,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{'page': page, 'per_page': perPage};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (searchIn != null && searchIn.isNotEmpty) {
        queryParams['search_in'] = searchIn;
      }

      if (filterBy != null && filterBy.isNotEmpty) {
        queryParams['filter_by'] = filterBy;
      }

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sort_by'] = sortBy;
      }

      final response = await _dio.get<Map<String, dynamic>>(
        '/notes/',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return right([]);
        }

        // API returns paginated response with 'results' array
        final resultsData = data['notes'] as List<dynamic>? ?? [];
        final notes = resultsData
            .map((json) => NoteModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return right(notes);
      }

      return left(ServerFailure(errorMessage: StringConstants.noteGetFailed));
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }

  @override
  Future<Either<Failure, NoteModel>> getNoteById({
    required String noteId,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/notes/$noteId');

      if (response.statusCode == 200) {
        final noteModel = NoteModel.fromJson(response.data!);
        return right(noteModel);
      }

      return left(ServerFailure(errorMessage: StringConstants.noteNotFound));
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }

  @override
  Future<Either<Failure, NoteModel>> updateNote({
    required NoteModel note,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/notes/${note.id}',
        data: note.toCreateRequest(),
      );

      if (response.statusCode == 200) {
        final updatedNote = NoteModel.fromJson(response.data!);
        return right(updatedNote);
      }

      return left(
        ServerFailure(errorMessage: StringConstants.noteUpdateFailed),
      );
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote({required String noteId}) async {
    try {
      final response = await _dio.delete<void>('/notes/$noteId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return right(null);
      }

      return left(
        ServerFailure(errorMessage: StringConstants.noteDeleteFailed),
      );
    } on DioException catch (e) {
      return DioErrorHandler.handleDioError(e);
    } catch (e) {
      return DioErrorHandler.handleUnexpectedError(e);
    }
  }
}
