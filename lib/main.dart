import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_keeper_app/add_notes-page.dart';
import 'package:notes_keeper_app/edit_notes_page.dart';
import 'package:notes_keeper_app/home.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/notes_detail.dart';
import 'package:notes_keeper_app/notes_page.dart';
import 'package:notes_keeper_app/routes.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Routes.home: (context) => Home(),
        Routes.notesPage: (context) => NotesPage(),
        Routes.addNotesPage: (context) => AddNotesPage(),
        Routes.notesDetailPage: (context) => NotesDetails(),
      },
      theme: ThemeData(
        primaryColor: Colors.pink,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
