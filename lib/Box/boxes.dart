import 'package:hive/hive.dart';
import 'package:notes_keeper_app/models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notesBox');
}
