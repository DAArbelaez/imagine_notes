import 'package:flutter_test/flutter_test.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'package:imagine_notes/features/home/domain/note.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_event.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notes_bloc_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockRepository;
  late NotesBloc notesBloc;

  final testCategory = Category(id: 'cat1', name: 'Work', color: '#FF0000');

  final note1 = Note(
    id: 'note1',
    title: 'Meeting',
    content: 'Discuss project updates',
    category: testCategory,
    ownerId: 'user1',
    timestamp: DateTime.now(),
  );

  final note2 = Note(
    id: 'note2',
    title: 'Lunch',
    content: 'Team lunch at noon',
    category: testCategory,
    ownerId: 'user1',
    timestamp: DateTime.now(),
  );

  setUp(() {
    mockRepository = MockHomeRepository();
    notesBloc = NotesBloc(mockRepository);
  });

  tearDown(() async {
    await notesBloc.close();
  });

  test('emits NotesLoadInProgress then NotesLoadSuccess on successful LoadNotes event', () async {
    // When getNotesStream is called with no category filter, return a stream with note1 and note2.
    when(mockRepository.getNotesStream(categoryId: null)).thenAnswer((_) => Stream.value([note1, note2]));

    notesBloc.add(const LoadNotes());

    // Expect the states: first a progress state, then a success state containing both notes.
    await expectLater(
      notesBloc.stream,
      emitsInOrder([
        isA<NotesLoadInProgress>(),
        isA<NotesLoadSuccess>().having((state) => state.notes, 'notes', [note1, note2]),
      ]),
    );
  });

  test('filters notes with SearchQueryChanged event', () async {
    when(mockRepository.getNotesStream(categoryId: null)).thenAnswer((_) => Stream.value([note1, note2]));

    notesBloc.add(const LoadNotes());

    await Future.delayed(const Duration(milliseconds: 100));

    notesBloc.add(const SearchQueryChanged('meet'));

    // Expect that the filtered list only includes note1.
    await expectLater(
      notesBloc.stream,
      emitsThrough(
        isA<NotesLoadSuccess>()
            .having((state) => state.notes.length, 'filtered length', 1)
            .having((state) => state.notes.first.title, 'title', 'Meeting'),
      ),
    );
  });
}
