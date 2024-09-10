import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/services/firebase/fiirebase.service.dart';

class NoteRepository extends FirebaseService {
  final db = FirebaseFirestore.instance;
  @override
  Future<bool> addNote(String userId, Note note) async {
    try {
      await db.collection('notes').doc(userId).set(note.toMap());
      return true;
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'firebase');
      return false;
    }
  }

  @override
  Future<void> deleteNote(String userId, Note note) async {
    db.collection('notes').doc(userId).delete();
  }

  @override
  Future<List<Note>> getNotes(String userId) async {
    List<Note> notes = [];

    try {
      notes = await db.collection('notes').get().then((snapshot) {
        return snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
      });
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'fetch notes');
    }
    return notes;
  }

  @override
  Future<void> updateNote(String userId, Note note) async {
    final userNoteRef = db.collection("notes").doc(userId);
    userNoteRef
        .update(note.toMap())
        .then((_) => log('Updated Note'))
        .catchError(
          (error) => log(error.toString()),
        );
  }
}
