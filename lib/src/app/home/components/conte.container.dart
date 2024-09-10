import 'package:flutter/widgets.dart';
import 'package:notekeeper/src/data/note.dart';
import 'package:notekeeper/src/extensions/extensions.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
        ],
      ),
    );
  }
}
