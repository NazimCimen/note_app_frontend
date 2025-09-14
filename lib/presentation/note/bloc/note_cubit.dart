import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';

part 'note_state.dart';

/// Cubit for managing note-related state
class NoteCubit extends Cubit<NoteState> {
  final CreateNoteUseCase createNoteUseCase;

  NoteCubit({
    required this.createNoteUseCase,
  }) : super(const NoteState.initial());

  /// Create a new note
  Future<void> createNote({
    required String title,
    required String content,
    bool isFavorite = false,
  }) async {
    if (state is NoteLoading) return;
    
    emit(const NoteState.loading());

    final params = CreateNoteParams(
      title: title,
      content: content,
      isFavorite: isFavorite,
    );

    final result = await createNoteUseCase(params);

    result.fold(
      (failure) => emit(NoteState.failure(failure.errorMessage)),
      (note) => emit(NoteState.success(note)),
    );
  }

  /// Reset state to initial
  void resetState() {
    emit(const NoteState.initial());
  }
}
