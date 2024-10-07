import 'package:flutter/material.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/hiveServices/notes_service.dart';
import 'package:notes_keeper_app/helpers/routes.dart';
import 'package:notes_keeper_app/helpers/sizeConfig.dart';

class EditNotesPage extends StatefulWidget {
  final String des;
  final String title;
  final int index;
  const EditNotesPage(
      {super.key, required this.des, required this.title, required this.index});

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  late TextEditingController _titleController;
  late TextEditingController _desController;
  final _isImportant = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _desController = TextEditingController(text: widget.des);
  }

  @override
  Widget build(BuildContext context) {
    final NotesService _notesService = NotesService();
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
            "Add Notes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (_titleController.text.isNotEmpty &&
                  _desController.text.isNotEmpty) {
                var notes = NotesModel(
                    description: _desController.text,
                    title: _titleController.text,
                    isImportant: _isImportant);
                await _notesService.editNotes(widget.index, notes);
                Navigator.pushNamed(context, Routes.notesPage);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Please enter something"),
                    );
                  },
                );
              }
            },
            icon: Icon(Icons.done),
            color: Colors.pink[400],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              SizedBox(
                height: SizeConfig.blockH! * 1,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  focusColor: Colors.pink[400],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockH! * 5,
              ),
              Text(
                "Description",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              SizedBox(
                height: SizeConfig.blockH! * 1,
              ),
              TextField(
                controller: _desController,
                decoration: InputDecoration(
                  focusColor: Colors.pink[400],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
