import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/notes_cubit.dart';
import '../../models/note_model.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteModel? note;

  const NoteDetailScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int selectedColorHex;

  final List<int> availableColors = const [
    0xFFFFF1C5, // Yellow
    0xFFFFD6D6, // Pink
    0xFFD4EFFF, // Blue
    0xFFD8F3DC, // Green
    0xFFE8DDFF, // Purple
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
    selectedColorHex = widget.note?.colorHex ?? availableColors[0];
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void saveNote() {
    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }

    if (widget.note == null) {
      final newNote = NoteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        content: contentController.text,
        colorHex: selectedColorHex,
      );
      context.read<NotesCubit>().addNote(newNote);
    } else {
      widget.note!.title = titleController.text;
      widget.note!.content = contentController.text;
      widget.note!.colorHex = selectedColorHex;
      widget.note!.updatedAt = DateTime.now();
      context.read<NotesCubit>().updateNote(widget.note!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(selectedColorHex),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: saveNote,
        ),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.black87),
              onPressed: () {
                context.read<NotesCubit>().deleteNote(widget.note!.id);
                Navigator.pop(context);
              },
            ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black87),
            onPressed: saveNote,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: TextField(
                        controller: contentController,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Note',
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: availableColors.map((colorHex) {
                  final isSelected = colorHex == selectedColorHex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorHex = colorHex;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(colorHex),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black87 : Colors.black26,
                          width: isSelected ? 2.5 : 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}