import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_keeper_app/Box/boxes.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/hiveServices/notes_service.dart';
import 'package:notes_keeper_app/helpers/routes.dart';

class RecentNotes extends StatelessWidget {
  const RecentNotes({
    super.key,
    required NotesService notesService,
  }) : _notesService = notesService;

  final NotesService _notesService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _notesService.getAllNotes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ValueListenableBuilder(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, widget) {
              return box.length > 0
                  ? ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        var notes = box.getAt(index);
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.notesDetailPage,
                              arguments: NotesDetailArgument(
                                  Description: notes.description,
                                  title: notes.title,
                                  isImportant: notes.isImportant,
                                  index: index)),
                          child: Card(
                            surfaceTintColor:
                                Color.fromARGB(255, 148, 140, 140),
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.pink[300],
                                ),
                                onPressed: () {
                                  _notesService.deleteNotes(index);
                                },
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text("You have not add any notes yet!"),
                    );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
