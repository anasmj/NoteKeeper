import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/services/firebase/firestore/fiirebase.service.dart';

class NoteRepository extends FirebaseService {
  final db = FirebaseFirestore.instance;
  @override
  Future<bool> addNote(String userId, Note note) async {
    try {
      final notesCollection =
          db.collection('users').doc(userId).collection('notes');
      DocumentReference newNoteRef = notesCollection.doc();
      newNoteRef.set(note.toMap());

      return true;
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'firebase');
      return false;
    }
  }

  @override
  Future<bool> deleteNote(String userId, Note note) async {
    try {
      DocumentReference noteRef =
          db.collection('users').doc(userId).collection('notes').doc(note.id);

      await noteRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Note>> getNotes(String userId) async {
    List<Note> notes = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notes')
          .get();

      List<Note> notes = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        notes.add(Note.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id));
      }

      return notes;
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'fetch notes');
    }
    return notes;
  }

  @override
  Future<bool> updateNote(String userId, Note note) async {
    try {
      DocumentReference noteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(note.id);

      await noteRef.update(note.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
