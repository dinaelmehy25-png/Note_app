import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/note_model.dart';
import 'controllers/theme_controller.dart';
import 'views/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();


  Hive.registerAdapter(NoteTypeAdapter());
  Hive.registerAdapter(CheckItemModelAdapter());
  Hive.registerAdapter(NoteModelAdapter());

 
  await Hive.openBox<NoteModel>('notes_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        themeMode: themeController.themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFE8DEF8),
            foregroundColor: Colors.black87,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF4A4458),
            foregroundColor: Colors.white,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}