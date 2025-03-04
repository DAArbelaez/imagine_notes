import 'package:equatable/equatable.dart';
import 'package:imagine_notes/features/home/domain/note.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NotesEvent {
  final String? categoryId;

  const LoadNotes({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class AddNote extends NotesEvent {
  final FormGroup form;

  const AddNote({required this.form});

  @override
  List<Object?> get props => [form];
}

class DeleteNote extends NotesEvent {
  final String noteId;

  const DeleteNote(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

class NotesUpdated extends NotesEvent {
  final List<Note> notes;

  const NotesUpdated(this.notes);

  @override
  List<Object?> get props => [notes];
}

class SearchQueryChanged extends NotesEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateNote extends NotesEvent {
  final Note note;
  final FormGroup form;
  final void Function()? onSuccess;
  final void Function(String error)? onFailure;

  const UpdateNote(
    this.note,
    this.form, {
    this.onSuccess,
    this.onFailure,
  });

  @override
  List<Object?> get props => [note, form];
}
