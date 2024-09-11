import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/providers/auth.provider.dart';
import 'package:notekeeper/src/services/firebase/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes.provider.g.dart';

@riverpod
class NotesP extends _$NotesP {
  final noteRepo = NoteRepository();
  @override
  Future<List<Note>> build() async {
    final userId = ref.watch(authProvider).id;
    if (userId == null) return [];
    return noteRepo.getNotes(userId);
  }

  Future<bool> save(String userId, Note note) async {
    final isSaved = await noteRepo.addNote(userId, note);
    if (isSaved) {
      state = AsyncData([...state.value ?? [], note]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateNote(String userId, Note note) async {
    final isUpdated = await noteRepo.updateNote(userId, note);
    if (isUpdated) {
      List<Note> notes = state.value ?? [];
      notes.removeWhere((n) => note.id == n.id);
      notes.insert(0, note);
      state = AsyncData(notes);
    }

    return isUpdated;
  }

  Future delete(Note note) async {
    if (await noteRepo.deleteNote(ref.read(authProvider).id!, note)) {
      state = AsyncData(state.value ?? []
        ..removeWhere((n) => n.id == note.id));
    }
  }
}
