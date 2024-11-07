import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteProvider extends ChangeNotifier {
  // کلاس NoteProvider از ChangeNotifier ارث‌بری می‌کند تا امکان اطلاع‌رسانی تغییرات
  // در وضعیت (state) یادداشت‌ها را به ویجت‌ها فراهم کند.
  late Box _box;
  final List<Note> _notes = [];
  // لیست خصوصی (private) برای نگهداری تمام یادداشت‌ها.

  List<Note> _filteredNotes = [];
  // لیست خصوصی برای نگهداری یادداشت‌های فیلتر شده، زمانی که جستجویی انجام شود.

  List<Note> get notes => _filteredNotes.isEmpty ? _notes : _filteredNotes;
  // یک getter برای دسترسی به یادداشت‌ها.
  // اگر _filteredNotes خالی باشد، تمام یادداشت‌ها را (یعنی _notes) برمی‌گرداند؛
  // در غیر این صورت، یادداشت‌های فیلتر شده را برمی‌گرداند.

  var uuid = const Uuid();
  // نمونه‌ای از کلاس Uuid برای ایجاد شناسه‌های یکتا (unique IDs) برای یادداشت‌ها.
  NoteProvider() {
    _initializeHive();
    loadNotesFromHive();
  }

  Future<void> _initializeHive() async {
    _box = Hive.box('notesBox');
    // استفاده از Box باز شده در main
  }

  void addNote(String titleText, String contentText) {
    final newNote = Note(
      id: uuid.v4(),
      title: titleText,
      content: contentText,
    );
    _notes.add(newNote);
    _saveNotesToHive();

    notifyListeners();
    // فراخوانی notifyListeners به ویجت‌ها اطلاع می‌دهد که وضعیت تغییر کرده و باید دوباره ترسیم شوند.
  }

  void loadNotesFromHive() {
    final storedNotes = _box.get('storedNotes', defaultValue: []);
    if (storedNotes.isNotEmpty) {
      _notes.clear();
      for (var noteData in storedNotes) {
        _notes.add(Note.fromMap(Map<String, dynamic>.from(noteData)));
      }
      notifyListeners();
    }
  }

  void _saveNotesToHive() {
    final noteData = _notes.map((note) => note.toMap()).toList();
    _box.put('storedNotes', noteData);
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotesToHive();
    notifyListeners();
  }

  void searchNotes(String query) {
    // متدی برای جستجوی یادداشت‌ها بر اساس رشته ورودی (query).
    if (query.isEmpty) {
      _filteredNotes = [];
      // اگر query خالی باشد، لیست _filteredNotes خالی تنظیم می‌شود
      // و در نتیجه تمام یادداشت‌ها نشان داده می‌شوند.
    } else {
      _filteredNotes = _notes
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // اگر query خالی نباشد، در _notes جستجو انجام می‌شود.
      // یادداشت‌هایی که عنوان یا محتوای آن‌ها شامل query باشد (صرف‌نظر از حروف بزرگ یا کوچک) به لیست _filteredNotes اضافه می‌شوند.
    }
    notifyListeners();
    // اطلاع‌رسانی به ویجت‌ها که نتایج جستجو تغییر کرده‌اند.
  }
}
