import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_keeper_app/Box/boxes.dart';
import 'package:notes_keeper_app/arguments/notes_detail_screen_argument.dart';
import 'package:notes_keeper_app/models/notes_model.dart';
import 'package:notes_keeper_app/notes_service.dart';
import 'package:notes_keeper_app/routes.dart';
import 'package:notes_keeper_app/sizeConfig.dart';

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

  int indexCategory = 0;
  @override
  Widget build(BuildContext context) {
    List categoryList = ["Recent Notes", "Important Notes"];

    final NotesService _notesService = NotesService();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes Keeper",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        actions: [
          Icon(Icons.light_mode_outlined),
          SizedBox(
            width: SizeConfig.blockW! * 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            homeHeader(),
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
                                  : Colors.black45,
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

class ImportantNotes extends StatelessWidget {
  const ImportantNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("new "),
    );
  }
}

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
              return ListView.builder(
                  itemCount: 4,
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
    );
  }
}

class homeHeader extends StatelessWidget {
  const homeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          InkWell(
            onTap: () => {Navigator.pushNamed(context, Routes.notesPage)},
            child: Container(
              height: SizeConfig.blockH! * 30,
              width: SizeConfig.blockW! * 43,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffe55d87), Color(0xff5fc3e4)],
                    stops: [0, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 188, 187, 187),
                      offset: Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockH! * 2,
                    horizontal: SizeConfig.blockW! * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notes",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      "122",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: SizeConfig.blockH! * 30,
            width: SizeConfig.blockW! * 43,
            decoration: BoxDecoration(
                color: const Color.fromARGB(201, 238, 238, 238),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockH! * 2,
                  horizontal: SizeConfig.blockW! * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important Notes",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38),
                  ),
                  Spacer(),
                  Text(
                    "14",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
