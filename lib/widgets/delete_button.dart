// delete_button.dart
import 'package:flutter/material.dart';
import 'package:my_note_app/models/note_provider.dart';
import 'package:provider/provider.dart';
// مسیر را به فایل note_provider.dart تغییر دهید

class DeleteButton extends StatelessWidget {
  final String noteId;

  DeleteButton({required this.noteId});

  Future<void> confirmDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          icon: Icon(Icons.info, color: Colors.grey),
          title: Text(
            "آیا مطمئنی از پاک کردن؟",
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Provider.of<NoteProvider>(context, listen: false)
                      .deleteNote(noteId); // از noteId استفاده کردیم
                  Navigator.of(context).pop();
                },
                child: Text(
                  "بله",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  "خیر",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => confirmDialog(context),
    );
  }
}
