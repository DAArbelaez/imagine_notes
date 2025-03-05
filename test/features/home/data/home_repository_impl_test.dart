import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/domain/note.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  User,
  CollectionReference,
  DocumentReference,
  Query,
  QuerySnapshot,
  QueryDocumentSnapshot,
])
void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockUser mockUser;
  late HomeRepositoryImpl repository;

  setUp(() {
    // Set up mocks for FirebaseAuth and User.
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockUser = MockUser();

    // Stub the user uid.
    when(mockUser.uid).thenReturn('testUser');
    when(mockAuth.currentUser).thenReturn(mockUser);

    repository = HomeRepositoryImpl(firebaseAuth: mockAuth, firestore: mockFirestore);
  });

  test('logout calls signOut on FirebaseAuth', () async {
    await repository.logout();
    verify(mockAuth.signOut()).called(1);
  });

  test('createNote creates a note with correct data', () async {
    final mockNotesCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    final mockSubCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockNewDoc = MockDocumentReference<Map<String, dynamic>>();

    when(mockFirestore.collection('notes')).thenReturn(mockNotesCollection);
    when(mockNotesCollection.doc('testUser')).thenReturn(mockUserDoc);
    when(mockUserDoc.collection('userNotes')).thenReturn(mockSubCollection);
    when(mockSubCollection.doc()).thenReturn(mockNewDoc);

    when(mockNewDoc.id).thenReturn('generatedDocId');
    when(mockNewDoc.set(any)).thenAnswer((_) async => Future.value());

    final testCategory = Category(id: 'cat1', name: 'Work', color: '#FF0000');
    final note = Note(
      id: '',
      title: 'Test Note',
      content: 'Note content',
      category: testCategory,
      ownerId: '',
      timestamp: DateTime.now(),
    );

    await repository.createNote(note);

    // Verify that set() was called with a Map that contains the expected title.
    verify(mockNewDoc.set(argThat(containsPair('title', 'Test Note')))).called(1);
  });

  test('deleteNote deletes the correct document', () async {
    final mockNotesCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    final mockSubCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockDoc = MockDocumentReference<Map<String, dynamic>>();

    when(mockFirestore.collection('notes')).thenReturn(mockNotesCollection);
    when(mockNotesCollection.doc('testUser')).thenReturn(mockUserDoc);
    when(mockUserDoc.collection('userNotes')).thenReturn(mockSubCollection);
    when(mockSubCollection.doc('note123')).thenReturn(mockDoc);
    when(mockDoc.delete()).thenAnswer((_) async => Future.value());

    await repository.deleteNote('note123');

    // Verify that delete() is called on the correct document.
    verify(mockDoc.delete()).called(1);
  });

  test('updateNote updates the correct document with new data', () async {
    final mockNotesCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    final mockSubCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockDoc = MockDocumentReference<Map<String, dynamic>>();

    when(mockFirestore.collection('notes')).thenReturn(mockNotesCollection);
    when(mockNotesCollection.doc('testUser')).thenReturn(mockUserDoc);
    when(mockUserDoc.collection('userNotes')).thenReturn(mockSubCollection);
    when(mockSubCollection.doc('note123')).thenReturn(mockDoc);
    when(mockDoc.update(any)).thenAnswer((_) async => Future.value());

    final testCategory = Category(id: 'cat1', name: 'Work', color: '#FF0000');
    final note = Note(
      id: 'note123',
      title: 'Updated Note',
      content: 'Updated content',
      category: testCategory,
      ownerId: 'testUser',
      timestamp: DateTime.now(),
    );

    await repository.updateNote(note);

    // Verify that update() was called with a Map that contains the updated title.
    verify(mockDoc.update(argThat(containsPair('title', 'Updated Note')))).called(1);
  });

  test('getNotesStream returns a list of notes', () async {
    final mockNotesCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    final mockSubCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockQuery = MockQuery<Map<String, dynamic>>();
    final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    final mockQueryDocSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

    final noteData = {
      'title': 'Stream Note',
      'content': 'Content from stream',
      'category': {'id': 'cat1', 'name': 'Work', 'color': '#FF0000'},
      'ownerId': 'testUser',
      'timestamp': Timestamp.now(),
    };

    when(mockFirestore.collection('notes')).thenReturn(mockNotesCollection);
    when(mockNotesCollection.doc('testUser')).thenReturn(mockUserDoc);
    when(mockUserDoc.collection('userNotes')).thenReturn(mockSubCollection);
    when(mockSubCollection.orderBy('timestamp', descending: true)).thenReturn(mockQuery);
    when(mockQuery.snapshots()).thenAnswer((_) => Stream.value(mockQuerySnapshot));

    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocSnapshot]);

    when(mockQueryDocSnapshot.data()).thenReturn(noteData);
    when(mockQueryDocSnapshot.id).thenReturn('note1');

    final stream = repository.getNotesStream();
    // Verify that the stream emits a list of notes with the correct title.
    await expectLater(
      stream,
      emits(isA<List<Note>>().having((notes) => notes.first.title, 'title', 'Stream Note')),
    );
  });
}
