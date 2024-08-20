import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_note_app/constant/colors.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:my_note_app/pages/edit.dart';
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

  var uuid = Uuid();
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

  // void searchNotes(String searchText) {
  //   setState(() {
  //     filterNotes = sampleNotes
  //         .where((note) =>
  //             note.title.toLowerCase().contains(searchText.toLowerCase()) ||
  //             note.content.toLowerCase().contains(searchText.toLowerCase()))
  //         .toList();
  //   });
  // }

  void deleteNote(index) {
    print("Index to delete: $index");
    setState(() {
      filterNotes.removeAt(index);
    });
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
                // onChanged: searchNotes,
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
            Expanded(
                child: ListView.builder(
              itemCount: filterNotes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(top: 30),
                  color: getRandomColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: RichText(
                        text: TextSpan(
                            text: "${filterNotes[index].title}",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18,
                                height: 1.5),
                            children: [
                          TextSpan(
                              text: "${filterNotes[index].content}",
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14,
                                  height: 1.5))
                        ])),
                    trailing: IconButton(
                      onPressed: () async {
                        final result = await confirmDilog(context);
                        if (result == true) {
                          deleteNote(index);
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EditScreen()));
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

  Future<dynamic> confirmDilog(BuildContext context) {
    return showDialog(
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          "بله",
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          "خیر",
                          style: TextStyle(color: Colors.white),
                        )),
                  ]));
        });
  }
}
