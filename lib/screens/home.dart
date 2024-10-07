import 'package:flutter/material.dart';

import 'package:notes_keeper_app/components/home_category_content.dart';
import 'package:notes_keeper_app/components/home_header.dart';
import 'package:notes_keeper_app/main.dart';

import 'package:notes_keeper_app/hiveServices/notes_service.dart';

import 'package:notes_keeper_app/helpers/sizeConfig.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void updateCategoryIndex(int index) {
    setState(() {
      indexCategory = index;
    });
  }

  bool isToggle = false;
  int indexCategory = 0;
  @override
  Widget build(BuildContext context) {
    List categoryList = ["Recent Notes", "Important Notes"];

    final NotesService _notesService = NotesService();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notes Keeper",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(isToggle
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              themeModeNotifier.value =
                  themeModeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
              setState(() {
                isToggle = !isToggle;
              });
            },
          ),
          SizedBox(
            width: SizeConfig.blockW! * 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            homeHeader(),
            //category selection options
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                height: SizeConfig.blockH! * 5,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          updateCategoryIndex(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 22),
                          child: Text(
                            categoryList[index],
                            style: TextStyle(
                              color: indexCategory == index
                                  ? Colors.pink
                                  : Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                              fontWeight: indexCategory == index
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            homeCategoryContent(
                indexCategory: indexCategory, notesService: _notesService),
          ],
        ),
      ),
    );
  }
}
