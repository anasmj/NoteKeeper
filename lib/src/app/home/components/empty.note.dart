import 'package:flutter/material.dart';
import 'package:notekeeper/src/extensions/extensions.dart';

class EmptyNoteWidget extends StatelessWidget {
  const EmptyNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          'No Notes found',
          style: context.text.titleLarge,
        ),
        const Spacer(),
      ],
    );
  }
}
