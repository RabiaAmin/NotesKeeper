import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_keeper_app/helpers/theme.dart';
import 'package:notes_keeper_app/screens/add_notes-page.dart';
import 'package:notes_keeper_app/screens/home.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/screens/notes_detail.dart';
import 'package:notes_keeper_app/screens/notes_page.dart';
import 'package:notes_keeper_app/helpers/routes.dart';
import 'package:notes_keeper_app/screens/onboarding.dart';
import 'package:notes_keeper_app/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

// ValueNotifier to hold and manage the theme state
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());

  await Hive.openBox<NotesModel>('notesBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          routes: {
            Routes.home: (context) => Home(),
            Routes.notesPage: (context) => NotesPage(),
            Routes.addNotesPage: (context) => AddNotesPage(),
            Routes.notesDetailPage: (context) => NotesDetails(),
            Routes.onBoarding: (context) => OnBoarding(),
          },
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
