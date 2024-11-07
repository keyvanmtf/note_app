import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_note_app/models/note_provider.dart';
import 'package:my_note_app/pages/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('notesBox');
  runApp(ChangeNotifierProvider(
      create: (context) => NoteProvider(), child: const MainApp()));

  // این تابع main اپلیکیشن را اجرا می‌کند.
  // ChangeNotifierProvider برای مدیریت وضعیت NoteProvider به کار می‌رود.
  // با استفاده از provider، وضعیت یادداشت‌ها در کل اپلیکیشن قابل دسترسی است.
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  // کلاس اصلی اپلیکیشن که از StatelessWidget ارث‌بری می‌کند.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // localizationsDelegates برای پشتیبانی از بومی‌سازی و زبان‌های مختلف استفاده می‌شود.
        // این کد به Flutter اجازه می‌دهد تا محلی‌سازی رابط کاربری را به فارسی انجام دهد.

        supportedLocales: const [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        // supportedLocales زبانی را که اپلیکیشن پشتیبانی می‌کند، مشخص می‌کند.
        // اینجا زبان فارسی ایران انتخاب شده است.

        locale: const Locale("fa", "IR"),
        // locale زبانی را که اپلیکیشن به آن نمایش داده شود، تنظیم می‌کند.
        // اینجا فارسی ایران به عنوان زبان پیش‌فرض تنظیم شده است.

        debugShowCheckedModeBanner: false,
        // این خط نشانگر Debug را که در گوشه بالا سمت راست اپلیکیشن ظاهر می‌شود، غیرفعال می‌کند.

        home: HomePage());
    // home صفحه اولیه اپلیکیشن را مشخص می‌کند که HomePage است.
  }
}
