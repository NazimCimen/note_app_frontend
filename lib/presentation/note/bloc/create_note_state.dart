part of 'create_note_cubit.dart';

/// States for note operations
abstract class CreateNoteState extends Equatable {
  const CreateNoteState();

  @override
  List<Object?> get props => [];

  /// Get isFavorite from current state
  bool get isFavorite {
    if (this is NoteLoading) return (this as NoteLoading).isFavorite;
    if (this is NoteSuccess) return (this as NoteSuccess).isFavorite;
    if (this is NoteFailure) return (this as NoteFailure).isFavorite;
    return false; // NoteInitial için false döndür
  }

  /// Get isEditMode from current state
  bool get isEditMode {
    if (this is NoteLoading) return (this as NoteLoading).isEditMode;
    if (this is NoteSuccess) return (this as NoteSuccess).isEditMode;
    if (this is NoteFailure) return (this as NoteFailure).isEditMode;
    return false; // NoteInitial için false döndür
  }

  /// Initial state
  const factory CreateNoteState.initial() = NoteInitial;

  /// Loading state
  const factory CreateNoteState.loading({
    bool isFavorite,
    bool isEditMode,
  }) = NoteLoading;

  /// Success state with created note
  const factory CreateNoteState.success(
    NoteEntity note, {
    bool isFavorite,
    bool isEditMode,
  }) = NoteSuccess;

  /// Failure state with error message
  const factory CreateNoteState.failure(
    String message, {
    bool isFavorite,
    bool isEditMode,
  }) = NoteFailure;

  /// Keywords state
  const factory CreateNoteState.keywords(String keywords) = NoteKeywords;

  /// Summary state
  const factory CreateNoteState.summary(String summary) = NoteSummary;

  /// Keywords failure state
  const factory CreateNoteState.keywordsFailure(String message) =
      NoteKeywordsFailure;

  /// Summary failure state
  const factory CreateNoteState.summaryFailure(String message) =
      NoteSummaryFailure;

  /// Keywords reset state
  const factory CreateNoteState.keywordsReset() = NoteKeywordsReset;

  /// Summary reset state
  const factory CreateNoteState.summaryReset() = NoteSummaryReset;

  /// Summary loading state
  const factory CreateNoteState.summaryLoading() = NoteSummaryLoading;

  /// Keywords loading state
  const factory CreateNoteState.keywordsLoading() = NoteKeywordsLoading;

  /// Show exit dialog state
  const factory CreateNoteState.showExitDialog() = NoteShowExitDialog;

  /// Go back state
  const factory CreateNoteState.goBack() = NoteGoBack;

  /// Validation error state
  const factory CreateNoteState.validationError(String message) = NoteValidationError;
}

/// Initial state
class NoteInitial extends CreateNoteState {
  const NoteInitial();

  @override
  List<Object?> get props => [];
}

/// Loading state
class NoteLoading extends CreateNoteState {
  const NoteLoading({
    this.isFavorite = false,
    this.isEditMode = false,
  });

  final bool isFavorite;
  final bool isEditMode;

  @override
  List<Object?> get props => [isFavorite, isEditMode];
}

/// Success state
class NoteSuccess extends CreateNoteState {
  const NoteSuccess(
    this.note, {
    this.isFavorite = false,
    this.isEditMode = false,
  });

  final NoteEntity note;
  final bool isFavorite;
  final bool isEditMode;

  @override
  List<Object?> get props => [note, isFavorite, isEditMode];
}

/// Failure state
class NoteFailure extends CreateNoteState {
  const NoteFailure(
    this.message, {
    this.isFavorite = false,
    this.isEditMode = false,
  });

  final String message;
  final bool isFavorite;
  final bool isEditMode;

  @override
  List<Object?> get props => [message, isFavorite, isEditMode];
}

/// Keywords state
class NoteKeywords extends CreateNoteState {
  const NoteKeywords(this.keywords);

  final String keywords;

  @override
  List<Object?> get props => [keywords];
}

/// Summary state
///
class NoteSummary extends CreateNoteState {
  const NoteSummary(this.summary);
  final String summary;
  @override
  List<Object?> get props => [summary];
}

/// Keywords failure state
class NoteKeywordsFailure extends CreateNoteState {
  const NoteKeywordsFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

/// Summary failure state
class NoteSummaryFailure extends CreateNoteState {
  const NoteSummaryFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

/// Summary loading state
class NoteSummaryLoading extends CreateNoteState {
  const NoteSummaryLoading();
}

/// Keywords loading state
class NoteKeywordsLoading extends CreateNoteState {
  const NoteKeywordsLoading();
}

/// Keywords reset state
class NoteKeywordsReset extends CreateNoteState {
  const NoteKeywordsReset();
}

/// Summary reset state
class NoteSummaryReset extends CreateNoteState {
  const NoteSummaryReset();
}

/// Show exit dialog state
class NoteShowExitDialog extends CreateNoteState {
  const NoteShowExitDialog();
}

/// Go back state
class NoteGoBack extends CreateNoteState {
  const NoteGoBack();
}

/// Validation error state
class NoteValidationError extends CreateNoteState {
  const NoteValidationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
