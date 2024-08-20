import 'package:flutter/material.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:my_note_app/pages/home.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  final List<Note>? notes;
  EditScreen({super.key, this.notes});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late List<Note> notes = [];
  TextEditingController _titleController = TextEditingController();

  TextEditingController _contentController = TextEditingController();

  var uuid = Uuid();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void _addNote() {
  //   setState(() {
  //     notes.add(Note(
  //       id: uuid.v4(),
  //       title: _titleController.text,
  //       content: _contentController.text,
  //     ));
  //     _titleController.clear();
  //     _contentController.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "عنوان",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade500, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white),
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
          String titleText = _titleController.text;
          String contentText = _contentController.text;

          Navigator.pop(context, {
            'title': titleText,
            'content': contentText,
          });
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          Icons.save,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
