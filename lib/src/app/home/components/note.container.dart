import 'package:flutter/material.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/extensions/extensions.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    super.key,
    required this.note,
    this.onDelete,
    this.onTap,
  });
  final Note note;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: context.theme.primaryColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title ?? '',
              style: context.text.titleMedium,
            ),
            Text(
              note.content ?? '',
            ),
            const Spacer(),
            Text('${note.date ?? ''}'),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                iconSize: 28,
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
