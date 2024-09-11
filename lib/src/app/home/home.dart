import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/app/home/components/empty.note.dart';
import 'package:notekeeper/src/app/home/components/note.container.dart';
import 'package:notekeeper/src/app/home/drawer/drawer.dart';
import 'package:notekeeper/src/app/home/note.detail.dart';
import 'package:notekeeper/src/extensions/extensions.dart';
import 'package:notekeeper/src/providers/notes.provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(notesPProvider),
        child: ref.watch(notesPProvider).when(
              data: (notes) {
                if (notes.isEmpty) {
                  return const Center(
                    child: EmptyNoteWidget(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: notes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (_, i) => NoteContainer(
                      note: notes[i],
                      onTap: () => context.fadePush(NoteDetail(note: notes[i])),
                      onDelete: () async => await ref
                          .read(notesPProvider.notifier)
                          .delete(notes[i]),
                    ),
                  ),
                );
              },
              error: (e, s) => ErrorWidget(errorObj: e),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(const NoteDetail()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    this.errorObj,
  });
  final Object? errorObj;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
