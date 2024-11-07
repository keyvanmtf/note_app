import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_note_app/constant/colors.dart';
import 'package:my_note_app/models/note_model.dart';
import 'package:my_note_app/models/note_provider.dart';
import 'package:my_note_app/pages/edit.dart';
import 'package:my_note_app/widgets/delete_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final String? titleText, contentText;

  HomePage({
    super.key,
    this.titleText,
    this.contentText,
  });

  // کلاس وضعیت (State) برای HomePage که امکان تغییرات در UI را فراهم می‌کند.
  List<Note> filterNotes = [];

  // لیستی برای نگهداری یادداشت‌های فیلترشده در صورت جستجو.
  var uuid = const Uuid();

  getRandomColor() {
    // تابعی برای انتخاب رنگ تصادفی برای کارت‌ها.
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // متد build که UI اصلی این صفحه را می‌سازد.

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      // تنظیم رنگ پس‌زمینه صفحه به خاکستری تیره.

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        // تنظیم فاصله داخلی صفحه.

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // چینش اجزا در یک سطر با فاصله در دو سمت صفحه.

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
                // دکمه برای مرتب‌سازی یادداشت‌ها (هرچند عملیاتی برای آن تنظیم نشده است).
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
                onChanged: (value) {
                  Provider.of<NoteProvider>(context, listen: false)
                      .searchNotes(value);
                  // در هنگام تغییر متن ورودی، متد searchNotes برای جستجوی یادداشت‌ها فراخوانی می‌شود.
                },
                style: const TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "جستجو",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  // تنظیمات ظاهری برای ورودی جستجو، از جمله آیکون و استایل.

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  // تنظیم رنگ و حاشیه‌های باکس ورودی جستجو.
                )),
            const SizedBox(
              height: 25,
            ),
            Expanded(child:
                Consumer<NoteProvider>(builder: (context, noteProvider, child) {
              final notes = noteProvider.notes;
              return ListView.builder(
                itemCount: notes.length,
                // تعیین تعداد یادداشت‌ها.

                itemBuilder: (context, index) {
                  final note = notes[index];
                  // دریافت یادداشت جاری از NoteProvider.

                  return Card(
                    margin: const EdgeInsets.only(top: 30),
                    color: getRandomColor(),
                    // تنظیم رنگ کارت به صورت تصادفی با تابع getRandomColor.

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // تنظیم شکل کارت با لبه‌های گرد.

                    child: ListTile(
                        title: RichText(
                            text: TextSpan(
                                text: "${note.title} \n",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 20,
                                    height: 1.5),
                                children: [
                              TextSpan(
                                  text: note.content,
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 18,
                                      height: 1.5))
                            ])),
                        // استفاده از RichText برای نمایش عنوان و محتوای یادداشت با استایل‌های متفاوت.

                        trailing: DeleteButton(noteId: note.id)),
                    // دکمه حذف یادداشت.
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
          // کاربر را به صفحه EditScreen هدایت می‌کند تا یادداشت جدیدی اضافه کند.

          if (result != null) {
            Provider.of<NoteProvider>(context, listen: false).addNote(
              result['title'],
              result['content'],
            );
            // در صورت وجود نتیجه، یادداشت جدید به NoteProvider اضافه می‌شود.
          }
        },
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.white,
          // آیکون اضافه کردن یادداشت جدید.
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // تنظیم محل دکمه شناور به گوشه پایین سمت چپ صفحه.
    );
  }
}
