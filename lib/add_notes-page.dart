import 'package:flutter/material.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/notes_service.dart';
import 'package:notes_keeper_app/sizeConfig.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
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
                );
                await _notesService.addNotes(notes);
                Navigator.pop(context);
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
                    color: Colors.black54),
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
                    color: Colors.black54),
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
