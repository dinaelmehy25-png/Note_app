import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note_model.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  String searchQuery = '';

  // قراءة الملاحظات وتصفيتها
  void fetchNotes() {
    emit(NotesLoading());
    try {
      final box = Hive.box<NoteModel>('notes_box');
      List<NoteModel> allNotes = box.values.toList();

      List<NoteModel> filteredNotes = allNotes.where((n) {
        bool matchesStatus = !n.isArchived && !n.isTrashed;
        if (searchQuery.isEmpty) return matchesStatus;

        bool matchesQuery =
            n.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                n.content.toLowerCase().contains(searchQuery.toLowerCase());

        return matchesStatus && matchesQuery;
      }).toList();

      emit(NotesSuccess(filteredNotes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  // البحث
  void updateSearchQuery(String query) {
    searchQuery = query;
    fetchNotes();
  }

  // إضافة ملاحظة
  void addNote(NoteModel note) async {
    final box = Hive.box<NoteModel>('notes_box');
    await box.put(note.id, note);
    fetchNotes();
  }

  // تعديل ملاحظة
  void updateNote(NoteModel updatedNote) async {
    await updatedNote.save();
    fetchNotes();
  }

  // نقل للـ Trash
  void deleteNote(String id) async {
    final box = Hive.box<NoteModel>('notes_box');
    final note = box.values.firstWhere((n) => n.id == id);
    note.isTrashed = true;
    await note.save();
    fetchNotes();
  }

  // تثبيت الملاحظة
  void togglePin(String id) async {
    final box = Hive.box<NoteModel>('notes_box');
    final note = box.values.firstWhere((n) => n.id == id);
    note.isPinned = !note.isPinned;
    await note.save();
    fetchNotes();
  }

  // تحديث التشيك بوكس
  void toggleCheckItem(String noteId, String itemId) async {
    final box = Hive.box<NoteModel>('notes_box');
    final note = box.values.firstWhere((n) => n.id == noteId);
    final itemIndex = note.checkList.indexWhere((i) => i.id == itemId);
    if (itemIndex != -1) {
      note.checkList[itemIndex].isDone = !note.checkList[itemIndex].isDone;
      await note.save();
      fetchNotes();
    }
  }
}