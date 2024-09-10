import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/services/firebase/fiirebase.service.dart';

class NoteApi extends FirebaseService {
  final db = FirebaseFirestore.instance;
  @override
  Future<void> addNote(String userId, Note note) async {
    await db.collection('notest').doc(userId).set(note.toMap());
  }

  @override
  Future<void> deleteNote(String userId, Note note) async {
    db.collection('notes').doc(userId).delete();
  }
 
  @override
  Future<List<Note>> getNotes(String userId) {
    return db.collection('notes').get().then((snapshot) {
      return snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
    });
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
