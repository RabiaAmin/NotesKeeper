import 'package:flutter/material.dart';
import 'package:notes_keeper_app/screens/add_notes-page.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/screens/edit_notes_page.dart';
import 'package:notes_keeper_app/hiveServices/notes_service.dart';
import 'package:notes_keeper_app/helpers/routes.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({super.key});

  @override
  _NotesDetailsState createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  final NotesService _notesService = NotesService();
  late bool isImportant;
  late NotesDetailArgument args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as NotesDetailArgument;
    isImportant =
        args.isImportant; // Initialize with the current importance state
  }

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          IconButton(
            onPressed: () async {
              // Toggle the important state
              setState(() {
                isImportant = !isImportant;
              });

              // Update in Hive database
              await _notesService.markAsImportant(args.index, isImportant);
            },
            icon: Icon(
              isImportant ? Icons.star : Icons.star_outline,
              color: Colors.amber,
            ),
          ),
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
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodySmall?.color),
          ),
        ),
      ),
    );
  }
}
