import 'package:flutter/material.dart';
import 'package:notes_keeper_app/components/important_notes.dart';
import 'package:notes_keeper_app/components/recent_notes.dart';
import 'package:notes_keeper_app/screens/home.dart';
import 'package:notes_keeper_app/hiveServices/notes_service.dart';
import 'package:notes_keeper_app/helpers/sizeConfig.dart';

class homeCategoryContent extends StatelessWidget {
  const homeCategoryContent({
    super.key,
    required this.indexCategory,
    required NotesService notesService,
  }) : _notesService = notesService;

  final int indexCategory;
  final NotesService _notesService;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.blockH! * 45,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: indexCategory == 0
            ? RecentNotes(notesService: _notesService)
            : indexCategory == 1
                ? ImportantNotes()
                : Center(
                    child: Text("something went wrong"),
                  ));
  }
}
