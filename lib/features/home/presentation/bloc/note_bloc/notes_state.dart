import 'package:equatable/equatable.dart';
import 'package:imagine_notes/features/home/domain/note.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesLoadInProgress extends NotesState {}

class NotesLoadSuccess extends NotesState {
  final List<Note> notes;

  const NotesLoadSuccess(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesInvalidForm extends NotesState {}

class NotesLoadFailure extends NotesState {
  final String error;

  const NotesLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
