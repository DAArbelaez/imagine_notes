import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/domain/note.dart';

abstract class HomeRepository {
  Future<void> logout();

  Future<void> createNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String noteId);

  Stream<List<Note>> getNotesStream({String? categoryId});

  Stream<List<Category>> getCategories();
}

/// Implementation of [HomeRepository] that interacts with Firebase Firestore.
/// Manages authentication and CRUD operations for notes and categories.
class HomeRepositoryImpl implements HomeRepository {
  final FirebaseAuth _firebaseAuth;

  final FirebaseFirestore _firestore;

  late final String _userId;

  final String _notesCollection = 'notes';
  final String _notesSubCollection = 'userNotes';

  final String _categoriesCollection = 'categories';

  HomeRepositoryImpl({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance {
    _userId = _firebaseAuth.currentUser!.uid;
  }

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();

  /// Creates a new note in Firestore under the authenticated user's collection.
  @override
  Future<void> createNote(Note note) async {
    final docRef = _firestore
        .collection(_notesCollection)
        .doc(_userId)
        .collection(_notesSubCollection)
        .doc();

    await docRef.set(note
        .copyWith(
          id: docRef.id,
          ownerId: _userId,
        ).toMap());
  }

  /// Deletes a note from Firestore by its unique ID.
  @override
  Future<void> deleteNote(String noteId) async {
    await _firestore
        .collection(_notesCollection)
        .doc(_userId)
        .collection(_notesSubCollection)
        .doc(noteId)
        .delete();
  }

  /// Streams a list of notes belonging to the authenticated user.
  ///
  /// - Orders notes by `timestamp` (newest first).
  /// - Optionally filters by a specific category if provided.
  @override
  Stream<List<Note>> getNotesStream({String? categoryId}) {
    Query query = _firestore
        .collection(_notesCollection)
        .doc(_userId)
        .collection(_notesSubCollection);

    if (categoryId != null && categoryId.isNotEmpty) {
      query = query.where('category.id', isEqualTo: categoryId);
    }

    query = query.orderBy('timestamp', descending: true);

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note.fromMap(data);
      }).toList();
    });
  }

  /// Streams a list of available categories from Firestore.
  @override
  Stream<List<Category>> getCategories() {
    return _firestore
        .collection(_categoriesCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList());
  }

  /// Updates an existing note in Firestore with new data.
  @override
  Future<void> updateNote(Note note) async {
    await _firestore
        .collection(_notesCollection)
        .doc(_userId)
        .collection(_notesSubCollection)
        .doc(note.id)
        .update(note.toMap());
  }
}
