import 'package:flutter/material.dart';

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
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
