import 'package:hive/hive.dart';
import 'package:notes_keeper_app/models/notes_model.dart';

class NotesService {
  Future<Box<NotesModel>> get _box async =>
      await Hive.openBox<NotesModel>('notesBox');

  Future<void> addNotes(NotesModel notesModel) async {
    var box = await _box;
    await box.add(notesModel);
  }

  Future<List<NotesModel>> getAllNotes() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteNotes(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> editNotes(int index, NotesModel updatedNotesModel) async {
    var box = await _box;
    await box.putAt(index, updatedNotesModel);
  }
}
