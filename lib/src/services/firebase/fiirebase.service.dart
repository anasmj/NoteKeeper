import 'package:notekeeper/src/data/note.dart';

abstract class FirebaseService {
  //Firestore
  Future<void> addNote(String userId, Note note);

  Future<void> updateNote(String userId, Note note);

  Future<void> deleteNote(String userId, Note note);

  Future<List<Note>?> getNotes(String userId);

  // Future<Note?> getNote(String userId, String id);
}
