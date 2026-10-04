import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  late Box<NoteModel> _notesBox;
  final RxList<NoteModel> _notes = <NoteModel>[].obs;

  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
   
    _notesBox = Hive.box<NoteModel>('notes_box');

   
    _loadNotes();
  }

  void _loadNotes() {
    _notes.assignAll(_notesBox.values.toList());
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<NoteModel> get notes {
    return _notes.where((n) {
      bool matchesStatus = !n.isArchived && !n.isTrashed;

      if (searchQuery.isEmpty) {
        return matchesStatus;
      }

      bool matchesQuery =
          n.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              n.content.toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesStatus && matchesQuery;
    }).toList();
  }

  void addNote(NoteModel note) {
    _notesBox.put(note.id, note);
    _notes.insert(0, note);
  }


  void updateNote(NoteModel updatedNote) {
    updatedNote.save(); 

    final index = _notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      _notes.refresh();
    }
  }


  void toggleCheckItem(String noteId, String itemId) {
    final noteIndex = _notes.indexWhere((n) => n.id == noteId);
    if (noteIndex != -1) {
      final note = _notes[noteIndex];
      final itemIndex = note.checkList.indexWhere((i) => i.id == itemId);
      if (itemIndex != -1) {
        note.checkList[itemIndex].isDone = !note.checkList[itemIndex].isDone;
        note.save(); 
        _notes.refresh();
      }
    }
  }


  void deleteNote(String id) {
    final noteIndex = _notes.indexWhere((n) => n.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex].isTrashed = true;
      _notes[noteIndex].save(); 
      _notes.refresh();
    }
  }

  void togglePin(String id) {
    final noteIndex = _notes.indexWhere((n) => n.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex].isPinned = !_notes[noteIndex].isPinned;
      _notes[noteIndex].save(); 
      _notes.refresh();
    }
  }
}