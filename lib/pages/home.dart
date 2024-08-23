import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_note_app/constant/colors.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:my_note_app/models/note_provider.dart';
import 'package:my_note_app/pages/edit.dart';
import 'package:my_note_app/widgets/delete_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final String? titleText, contentText;
  const HomePage({
    super.key,
    this.titleText,
    this.contentText,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> filterNotes = [];

  var uuid = const Uuid();
  @override
  void initState() {
    super.initState();
    if (widget.titleText != null && widget.contentText != null) {
      setState(() {
        filterNotes.add(Note(
          id: uuid.v4(),
          title: widget.titleText!,
          content: widget.contentText!,
        ));
      });
    }
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "یادداشت ها",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.white,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                onChanged: (value) {
                  Provider.of<NoteProvider>(context, listen: false)
                      .searchNotes(value);
                },
                style: const TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "جستجو",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                )),
            SizedBox(
              height: 25,
            ),
            Expanded(child:
                Consumer<NoteProvider>(builder: (context, noteProvider, child) {
              return ListView.builder(
                itemCount: noteProvider.notes.length,
                itemBuilder: (context, index) {
                  final note = noteProvider.notes[index];
                  return Card(
                    margin: EdgeInsets.only(top: 30),
                    color: getRandomColor(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                        title: RichText(
                            text: TextSpan(
                                text: "${noteProvider.notes[index].title} \n",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 20,
                                    height: 1.5),
                                children: [
                              TextSpan(
                                  text: "${noteProvider.notes[index].content}",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 18,
                                      height: 1.5))
                            ])),
                        trailing: DeleteButton(noteId: note.id)),
                  );
                },
              );
            })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditScreen()));
          if (result != null) {
            Provider.of<NoteProvider>(context, listen: false).addNote(
              result['title'],
              result['content'],
            );
          }
        },
        child: Icon(
          Icons.add,
          size: 38,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
