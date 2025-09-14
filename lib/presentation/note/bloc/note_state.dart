part of 'note_cubit.dart';

/// States for note operations
abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];

  /// Initial state
  const factory NoteState.initial() = NoteInitial;

  /// Loading state
  const factory NoteState.loading() = NoteLoading;

  /// Success state with created note
  const factory NoteState.success(NoteEntity note) = NoteSuccess;

  /// Failure state with error message
  const factory NoteState.failure(String message) = NoteFailure;
}

/// Initial state
class NoteInitial extends NoteState {
  const NoteInitial();
}

/// Loading state
class NoteLoading extends NoteState {
  const NoteLoading();
}

/// Success state
class NoteSuccess extends NoteState {
  const NoteSuccess(this.note);

  final NoteEntity note;

  @override
  List<Object?> get props => [note];
}

/// Failure state
class NoteFailure extends NoteState {
  const NoteFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
