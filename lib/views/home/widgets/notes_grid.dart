import 'package:flutter/material.dart';
import '../../../models/note_model.dart';
import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  final List<NoteModel> notes;
  final Function(NoteModel) onNoteTap;

  const NotesGrid({
    Key? key,
    required this.notes,
    required this.onNoteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(
          note: note,
          onTap: () => onNoteTap(note),
        );
      },
    );
  }
}
