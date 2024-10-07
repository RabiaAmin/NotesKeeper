import 'package:flutter/material.dart';
import 'package:notes_keeper_app/Box/boxes.dart';
import 'package:notes_keeper_app/helpers/routes.dart';
import 'package:notes_keeper_app/helpers/sizeConfig.dart';

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
                  gradient: const LinearGradient(
                    colors: [Color(0xffe55d87), Color(0xff5fc3e4)],
                    stops: [0, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(179, 39, 38, 38),
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockH! * 2,
                    horizontal: SizeConfig.blockW! * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "See All Notes",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      Boxes.getData().length.toString(),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              InkWell(
                onTap: () =>
                    {Navigator.pushNamed(context, Routes.addNotesPage)},
                child: Container(
                    height: SizeConfig.blockH! * 13,
                    width: SizeConfig.blockW! * 43,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color:
                              Colors.pink.shade200, // Set border color to pink
                          width: 1.5, // Set border width as desired
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Add Note",
                        style: TextStyle(color: Colors.pink.shade200),
                      ),
                    )),
              ),
              SizedBox(height: SizeConfig.blockH! * 2),
              Container(
                height: SizeConfig.blockH! * 15,
                width: SizeConfig.blockW! * 43,
                decoration: BoxDecoration(
                    color: Color.fromARGB(72, 229, 93, 136),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockH! * 1,
                      horizontal: SizeConfig.blockW! * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Important Notes",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                      const Spacer(),
                      Text(
                        Boxes.getImportantNotes().length.toString(),
                        style: const TextStyle(
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
        ],
      ),
    );
  }
}
