import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/error/failure.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/update_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_keywords_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_summary_usecase.dart';
import 'package:flutter_note_app/core/utils/app_validators.dart';

part 'create_note_state.dart';

/// Cubit for managing note creation state
class CreateNoteCubit extends Cubit<CreateNoteState> {
  final CreateNoteUseCase _createNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final GenerateKeywordsUseCase _generateKeywordsUseCase;
  final GenerateSummaryUseCase _generateSummaryUseCase;
  
  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  
  // Form state
  bool isEditMode = false;
  NoteEntity? editingNote;
  
  CreateNoteCubit({
    required CreateNoteUseCase createNoteUseCase,
    required UpdateNoteUseCase updateNoteUseCase,
    required GenerateKeywordsUseCase generateKeywordsUseCase,
    required GenerateSummaryUseCase generateSummaryUseCase,
  }) : _createNoteUseCase = createNoteUseCase,
       _updateNoteUseCase = updateNoteUseCase,
       _generateKeywordsUseCase = generateKeywordsUseCase,
       _generateSummaryUseCase = generateSummaryUseCase,
       super(const CreateNoteState.initial());

  /// Create a new note
  Future<void> createNote(NoteEntity note) async {
    if (state is NoteLoading) return;

    emit(const CreateNoteState.loading());

    final result = await _createNoteUseCase(note);

    result.fold(
      (failure) => emit(CreateNoteState.failure(failure.errorMessage)),
      (createdNote) => emit(CreateNoteState.success(createdNote)),
    );
  }

  /// Update an existing note
  Future<void> updateNote(NoteEntity note) async {
    if (state is NoteLoading) return;

    emit(const CreateNoteState.loading());

    final result = await _updateNoteUseCase(note);

    result.fold(
      (Failure failure) => emit(CreateNoteState.failure(failure.errorMessage)),
      (NoteEntity updatedNote) => emit(CreateNoteState.success(updatedNote)),
    );
  }

  /// Reset state to initial
  void reset() {
    emit(const CreateNoteState.initial());
  }

  /// Handle back button press
  void handleBackPressed() {
    // Check if there are unsaved changes
    if (hasUnsavedChanges()) {
      // Show exit dialog - this should be handled by the view
      // For now, just emit a state to trigger the dialog
      emit(const CreateNoteState.showExitDialog());
    } else {
      // Just go back
      emit(const CreateNoteState.goBack());
    }
  }

  /// Handle save button press
  void handleSavePressed() {
    // Validate and save note
    final titleError = AppValidators.noteTitleValidator(titleController.text);
    if (titleError != null) {
      emit(CreateNoteState.validationError(titleError));
      return;
    }

    final note = NoteEntity(
      id: isEditMode ? editingNote?.id : null,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      isFavorite: state.isFavorite,
      summary: summaryController.text.trim().isNotEmpty ? summaryController.text.trim() : null,
      keywords: keywordsController.text.trim().isNotEmpty ? keywordsController.text.trim() : null,
    );

    if (isEditMode) {
      updateNote(note);
    } else {
      createNote(note);
    }
  }

  /// Check if there are unsaved changes
  bool hasUnsavedChanges() {
    return titleController.text.isNotEmpty ||
           contentController.text.isNotEmpty ||
           keywordsController.text.isNotEmpty ||
           summaryController.text.isNotEmpty;
  }

  /// Initialize with note data for editing
  void initializeForEdit(NoteEntity note) {
    isEditMode = true;
    editingNote = note;
    
    titleController.text = note.title;
    contentController.text = note.content;
    keywordsController.text = note.keywords ?? '';
    summaryController.text = note.summary ?? '';
    
    // Edit mode için loading state'e geç
    emit(NoteLoading(isFavorite: note.isFavorite, isEditMode: true));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    keywordsController.dispose();
    summaryController.dispose();
    return super.close();
  }

  /// Toggle favorite status
  void toggleFavorite() {
    final currentState = state;
    if (currentState is NoteLoading) {
      emit(NoteLoading(isFavorite: !currentState.isFavorite, isEditMode: currentState.isEditMode));
    } else if (currentState is NoteSuccess) {
      emit(NoteSuccess(currentState.note, isFavorite: !currentState.isFavorite, isEditMode: currentState.isEditMode));
    } else if (currentState is NoteFailure) {
      emit(NoteFailure(currentState.message, isFavorite: !currentState.isFavorite, isEditMode: currentState.isEditMode));
    } else {
      // NoteInitial için loading state'e geç
      emit(const NoteLoading(isFavorite: true, isEditMode: false));
    }
  }

  Future<void> generateKeywords(String content, String locale) async {
    // Validate content before generating keywords
    final contentValidation = _validateContentForAI(content);
    if (contentValidation != null) {
      emit(CreateNoteState.keywordsFailure(contentValidation));
      return;
    }

    emit(const CreateNoteState.keywordsLoading());

    final result = await _generateKeywordsUseCase(content, locale);

    result.fold(
      (failure) => emit(CreateNoteState.keywordsFailure(failure.errorMessage)),
      (keywords) => emit(CreateNoteState.keywords(keywords)),
    );
  }

  Future<void> generateSummary(String content, String locale) async {
    // Validate content before generating summary
    final contentValidation = _validateContentForAI(content);
    if (contentValidation != null) {
      emit(CreateNoteState.summaryFailure(contentValidation));
      return;
    }

    emit(const CreateNoteState.summaryLoading());

    final result = await _generateSummaryUseCase(content, locale);

    result.fold(
      (failure) => emit(CreateNoteState.summaryFailure(failure.errorMessage)),
      (summary) => emit(CreateNoteState.summary(summary)),
    );
  }

  void resetKeywords() {
    emit(const CreateNoteState.keywordsReset());
  }

  void resetSummary() {
    emit(const CreateNoteState.summaryReset());
  }

  /// Validates content for AI operations
  String? _validateContentForAI(String content) {
    final trimmedContent = content.trim();
    
    // Check if content is empty
    if (trimmedContent.isEmpty) {
      return StringConstants.geminiContentEmpty;
    }
    
    // Check if content is too short (less than 20 characters or 3 words)
    if (trimmedContent.length < 20 || trimmedContent.split(' ').length < 3) {
      return StringConstants.geminiContentTooShort;
    }
    
    return null; // Content is valid
  }
}
