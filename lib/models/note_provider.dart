import 'package:flutter/material.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  List<Note> get notes => _filteredNotes.isEmpty ? _notes : _filteredNotes;

  // List<Note> get notes => _notes;
  var uuid = Uuid();
  void addNote(String titleText, String contentText) {
    _notes.add(Note(
      id: uuid.v4(),
      title: titleText,
      content: contentText,
    ));
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      _filteredNotes = [];
    } else {
      _filteredNotes = _notes
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
