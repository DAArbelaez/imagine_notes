import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/domain/note.dart';
import 'notes_event.dart';
import 'notes_state.dart';

/// Manages note-related actions.
/// Handles loading, adding, updating, deleting, and filtering notes.
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final HomeRepositoryImpl repository = HomeRepositoryImpl();
  StreamSubscription<List<Note>>? _notesSubscription;
  List<Note> _allNotes = [];
  String _searchQuery = '';

  NotesBloc() : super(NotesLoadInProgress()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
    on<NotesUpdated>((event, emit) {
      _allNotes = event.notes;
      emit(NotesLoadSuccess(_applyFilter(_allNotes, _searchQuery)));
    });
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  /// Loads notes from Firestore and listens for updates.
  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoadInProgress());
    await _notesSubscription?.cancel();
    try {
      emit(NotesLoadInProgress());
      await _notesSubscription?.cancel();
      _notesSubscription = repository.getNotesStream(categoryId: event.categoryId).distinct().listen(
            (notes) => add(NotesUpdated(notes)),
            onError: (error) => emit(NotesLoadFailure(error.toString())),
          );
    } catch (e) {
      emit(NotesLoadFailure(e.toString()));
    }
  }

  /// Adds a new note to Firestore.
  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    final form = event.form;
    if (form.valid) {
      try {
        final title = form.value['title'] as String;
        final content = form.value['content'] as String;
        final category = form.value['category'] as Category;

        final note = Note(
          id: '',
          ownerId: '',
          title: title,
          content: content,
          category: category,
          timestamp: DateTime.now(),
        );

        await repository.createNote(note);

        form.reset();
      } catch (e) {
        emit(NotesLoadFailure(e.toString()));
      }
    } else {
      form.markAllAsTouched();
    }
  }

  /// Updates an existing note in Firestore.
  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    final form = event.form;
    if (form.valid) {
      try {
        final updatedTitle = form.control('title').value as String;
        final updatedContent = form.control('content').value as String;
        final updatedCategory = form.control('category').value as Category;

        final updatedNote = event.note.copyWith(
          title: updatedTitle,
          content: updatedContent,
          category: updatedCategory,
        );

        if (event.onSuccess != null) {
          event.onSuccess!();
        }

        await repository.updateNote(updatedNote);
      } catch (e) {
        if (event.onFailure != null) {
          event.onFailure!(e.toString());
        }
        emit(NotesLoadFailure(e.toString()));
      }
    } else {
      form.markAllAsTouched();
    }
  }

  /// Deletes a note by its ID.
  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      await repository.deleteNote(event.noteId);
    } catch (e) {
      emit(NotesLoadFailure(e.toString()));
    }
  }

  /// Filters notes based on the search query.
  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<NotesState> emit) {
    _searchQuery = event.query;
    final filtered = _applyFilter(_allNotes, _searchQuery);
    emit(NotesLoadSuccess(filtered));
  }

  /// Returns notes that match the search query.
  List<Note> _applyFilter(List<Note> notes, String query) {
    if (query.isEmpty) return notes;
    final lower = query.toLowerCase();
    return notes.where((note) {
      return note.title.toLowerCase().contains(lower) || note.content.toLowerCase().contains(lower);
    }).toList();
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
