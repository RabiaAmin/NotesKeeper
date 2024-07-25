import 'package:flutter/material.dart';
import 'package:notes_keeper_app/add_notes-page.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/edit_notes_page.dart';
import 'package:notes_keeper_app/routes.dart';

class NotesDetails extends StatelessWidget {
  const NotesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NotesDetailArgument;
    if (args == null) {
      return Scaffold(
        body: Center(
          child: Text('No data received!'),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNotesPage(
                        title: args.title,
                        des: args.Description,
                        index: args.index,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.pink[400],
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star_outline,
                  color: Colors.amber,
                )),
          ],
          title: Text(
            args.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              args.Description,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
        ));
  }
}
