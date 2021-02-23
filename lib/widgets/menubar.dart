import 'package:flexibletodo/UIs/addTask.dart';
import 'package:flexibletodo/UIs/dashboard.dart';
import 'package:flexibletodo/UIs/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuBar extends StatefulWidget {
  double sizeMenu, sizeAddTask, sizeProfile, sizeSetting, sizeHome;
  bool isMenu, isAddTask, isProfile, isSettings, isHome;
  MenuBar(
      {this.isMenu = false,
      this.isAddTask = false,
      this.isProfile = false,
      this.isSettings = false,
      this.isHome = false,
      this.sizeMenu = 30,
      this.sizeAddTask = 30,
      this.sizeProfile = 30,
      this.sizeSetting = 30,
      this.sizeHome = 30});
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
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
                  size: widget.sizeMenu,
                  color: widget.isMenu
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  setState(() {
                    widget.isAddTask = widget.isHome =
                        widget.isProfile = widget.isSettings = false;
                    widget.sizeAddTask = widget.sizeHome =
                        widget.sizeProfile = widget.sizeSetting = 30.0;
                    widget.isMenu = true;
                    widget.sizeMenu = 36;
                  });

                  Scaffold.of(context).openDrawer();
                },
              ),
              Text(
                'Menu',
                style: GoogleFonts.ubuntu(
                  fontWeight:
                      widget.isMenu ? FontWeight.bold : FontWeight.normal,
                  fontSize: widget.sizeMenu / 2,
                  color: widget.isMenu
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
                  size: widget.sizeHome,
                  color: widget.isHome
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Dash(),
                    ),
                  );
                },
              ),
              Text(
                'Home',
                style: GoogleFonts.ubuntu(
                  fontSize: widget.sizeHome / 2,
                  fontWeight:
                      widget.isHome ? FontWeight.bold : FontWeight.normal,
                  color: widget.isHome
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
                  size: widget.sizeAddTask,
                  color: widget.isAddTask
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
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
                  fontWeight:
                      widget.isAddTask ? FontWeight.bold : FontWeight.normal,
                  color: widget.isAddTask
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: widget.sizeAddTask / 2,
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
                  size: widget.sizeProfile,
                  color: widget.isProfile
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  widget.sizeSetting = 30;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                },
              ),
              Text(
                'Profile',
                style: GoogleFonts.ubuntu(
                  fontWeight:
                      widget.isProfile ? FontWeight.bold : FontWeight.normal,
                  color: widget.isProfile
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: widget.sizeProfile / 2,
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
                  size: widget.sizeSetting,
                  color: widget.isSettings
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                },
              ),
              Text(
                'Setting',
                style: GoogleFonts.ubuntu(
                  fontWeight:
                      widget.isSettings ? FontWeight.bold : FontWeight.normal,
                  color: widget.isSettings
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: widget.sizeSetting / 2,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
