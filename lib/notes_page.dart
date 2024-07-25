import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_keeper_app/Box/boxes.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/notes_service.dart';
import 'package:notes_keeper_app/routes.dart';
import 'package:notes_keeper_app/sizeConfig.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesService _notesService = NotesService();
    print("this is list of ${_notesService.getAllNotes()}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text(
            "My Notes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.addNotesPage);
              },
              icon: Icon(
                Icons.add,
                size: 28,
                color: Colors.pink[400],
              ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: FutureBuilder(
          future: _notesService.getAllNotes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder(
                valueListenable: Boxes.getData().listenable(),
                builder: (context, box, widget) {
                  return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        var notes = box.getAt(index);
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.notesDetailPage,
                              arguments: NotesDetailArgument(
                                  Description: notes.description,
                                  title: notes.title,
                                  index: index)),
                          child: Card(
                            surfaceTintColor:
                                const Color.fromARGB(201, 238, 238, 238),
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
                                    color: Colors.black45,
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
                      });
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
