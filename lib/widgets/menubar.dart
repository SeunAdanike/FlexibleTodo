import 'package:flexibletodo/UIs/addTask.dart';
import 'package:flexibletodo/UIs/allTask.dart';
import 'package:flexibletodo/UIs/dashboard.dart';
import 'package:flexibletodo/UIs/settings.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  double sizeMenu = 30, sizeAddTask = 30, sizeProfile = 30, sizeSetting = 30;
  double sizeHome = 36;
  bool isMenu = false, isAddTask = false, isProfile = false, isSettings = false;
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Color(0xFFD2CECE),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 1,
          bottom: 3,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: sizeMenu,
                  color: isMenu
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    isMenu = true;
                    isHome = isAddTask = isProfile = isSettings = false;
                    sizeMenu = 36;
                    sizeHome = sizeAddTask = sizeProfile = sizeSetting = 30;
                  });
                  Scaffold.of(context).openDrawer();
                },
              ),
              Text(
                'Menu',
                style: GoogleFonts.ubuntu(
                  fontWeight: isMenu ? FontWeight.bold : FontWeight.normal,
                  fontSize: sizeMenu / 2,
                  color: isMenu
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: sizeHome,
                  color: isHome
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    isHome = true;
                    isMenu = isAddTask = isProfile = isSettings = false;
                    sizeHome = 36;
                    sizeMenu = sizeAddTask = sizeProfile = sizeSetting = 30;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dash(),
                      ),
                    );
                  });
                },
              ),
              Text(
                'Home',
                style: GoogleFonts.ubuntu(
                  fontSize: sizeHome / 2,
                  fontWeight: isHome ? FontWeight.bold : FontWeight.normal,
                  color: isHome
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_box,
                  size: sizeAddTask,
                  color: isAddTask
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    isAddTask = true;
                    isMenu = isHome = isProfile = isSettings = false;
                    sizeAddTask = 36;
                    sizeMenu = sizeHome = sizeProfile = sizeSetting = 30;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddTask(),
                    ),
                  );
                },
              ),
              Text(
                'Add Task',
                style: GoogleFonts.ubuntu(
                  fontWeight: isAddTask ? FontWeight.bold : FontWeight.normal,
                  color: isAddTask
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: sizeAddTask / 2,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: sizeProfile,
                  color: isProfile
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    isProfile = true;
                    isMenu = isHome = isAddTask = isSettings = false;
                    sizeProfile = 36;
                    sizeMenu = sizeAddTask = sizeHome = sizeSetting = 30;
                  });
                },
              ),
              Text(
                'Profile',
                style: GoogleFonts.ubuntu(
                  fontWeight: isProfile ? FontWeight.bold : FontWeight.normal,
                  color: isProfile
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: sizeProfile / 2,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: sizeSetting,
                  color: isSettings
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    isSettings = true;
                    isMenu = isHome = isAddTask = isProfile = false;
                    sizeSetting = 36;
                    sizeMenu = sizeAddTask = sizeHome = sizeProfile = 30;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ),
                    );
                  });
                },
              ),
              Text(
                'Setting',
                style: GoogleFonts.ubuntu(
                  fontWeight: isSettings ? FontWeight.bold : FontWeight.normal,
                  color: isSettings
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: sizeSetting / 2,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
