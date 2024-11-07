import 'package:flutter/material.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:my_note_app/models/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  final List<Note>? notes;
  final Note? note;
  EditScreen({super.key, this.notes, this.note});

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  var uuid = const Uuid();

  // void _addNote() {
  @override
  Widget build(BuildContext context) {
    // بارگذاری داده‌های ذخیره شده در هنگام ساخت ویجت

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "عنوان",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _contentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "اینجا بنویسید",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ],
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final noteProvider =
                Provider.of<NoteProvider>(context, listen: false);
            noteProvider.addNote(
                _titleController.text, _contentController.text);

            // noteProvider.loadNotesFromHive();

            Navigator.pop(context);
          },
          elevation: 10,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(
            Icons.save,
            color: Colors.white,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
