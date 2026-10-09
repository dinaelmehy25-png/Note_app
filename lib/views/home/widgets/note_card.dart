import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/notes_cubit.dart';
import '../../../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const textColor = Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(note.colorHex),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.transparent : Colors.black.withOpacity(0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (note.title.isNotEmpty) ...[
              Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],
            if (note.type == NoteType.text)
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.8),
                  height: 1.3,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              )
            else
              Column(
                children: note.checkList.take(5).map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // التفاعل المباشر مع عنصر القائمة عبر الـ Cubit
                            context
                                .read<NotesCubit>()
                                .toggleCheckItem(note.id, item.id);
                          },
                          child: Icon(
                            item.isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            size: 18,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor.withOpacity(0.8),
                              decoration: item.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}