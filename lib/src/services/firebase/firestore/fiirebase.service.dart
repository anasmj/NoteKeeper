import 'package:notekeeper/src/data/note.dart';

abstract class FirebaseService {
  //Firestore
  Future<bool> addNote(String userId, Note note);

  Future<bool> updateNote(String userId, Note note);

  Future<bool> deleteNote(String userId, Note note);

  Future<List<Note>?> getNotes(String userId);
}
