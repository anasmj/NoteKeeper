import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/extensions/extensions.dart';
import 'package:notekeeper/src/providers/auth.provider.dart';
import 'package:notekeeper/src/providers/notes.provider.dart';

class NoteDetail extends ConsumerStatefulWidget {
  const NoteDetail({super.key, this.note});
  final Note? note;

  @override
  ConsumerState<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends ConsumerState<NoteDetail> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _noteContentFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? '';
    _contentController.text = widget.note?.content ?? '';
    _noteContentFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final userId = ref.watch(authProvider).id;
              if (userId == null) return;
              final isSaved = await ref.read(notesPProvider.notifier).save(
                    userId,
                    Note(
                      title: _titleController.text,
                      content: _contentController.text,
                      date: DateTime.now(),
                    ),
                  );
              if (!context.mounted) return;
              if (isSaved) {
                Navigator.pop(context);
                context.showSnack('Note saved!');
              } else {
                context.showSnack('Could not save, Try again later');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
                child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            )),
            Expanded(
              flex: 6,
              child: TextField(
                focusNode: _noteContentFocusNode,
                controller: _contentController,
                maxLines: 10,
                decoration: const InputDecoration(
                  // labelText: 'Note',
                  hintText: 'Note',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}