import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_keeper_app/Box/boxes.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/hiveServices/notes_service.dart';
import 'package:notes_keeper_app/helpers/routes.dart';

class ImportantNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotesService _notesService = NotesService();

    return ValueListenableBuilder(
      valueListenable: Boxes.getData().listenable(), // Listen to the entire box
      builder: (context, Box<NotesModel> box, _) {
        // Filter important notes within the builder
        final importantNotes =
            box.values.where((note) => note.isImportant).toList();

        return ListView.builder(
            itemCount: importantNotes.length,
            itemBuilder: (context, index) {
              var notes = importantNotes[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, Routes.notesDetailPage,
                    arguments: NotesDetailArgument(
                        Description: notes.description,
                        title: notes.title,
                        isImportant: notes.isImportant,
                        index: index)),
                child: Card(
                  surfaceTintColor: Color.fromARGB(255, 148, 140, 140),
                  child: ListTile(
                    title: Text(
                      notes!.title,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Text(
                      notes.description,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          overflow: TextOverflow.ellipsis),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        // Toggle the importance state
                        bool newImportance = !notes.isImportant;

                        // Update the note's importance in the database
                        await _notesService.markAsImportant(
                            notes.key as int, newImportance);

                        // Optionally, you could trigger a UI update or show a message
                        // e.g., ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Note updated!')),
                        // );
                      },
                      icon: Icon(
                          notes.isImportant ? Icons.star : Icons.star_border),
                      color: Colors.amber,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
