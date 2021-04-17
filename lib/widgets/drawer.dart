import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexibletodo/UIs/allTask.dart';
import 'package:flexibletodo/UIs/categories.dart';
import 'package:flexibletodo/UIs/filterScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  @override
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 28.0,
          left: 10,
          right: 10,
          bottom: 18,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(),
              Column(
                children: [
                  Text(
                    'Hello!',
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    ((hour >= 0 && hour <= 11) && minute <= 59)
                        ? 'Good Morning!'
                        : ((hour > 11 && hour <= 16) && minute <= 59)
                            ? 'Good Afternoon!'
                            : 'Good Evening!',
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.italic,
                      color: Colors.yellowAccent,
                      fontSize: 30,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Categories(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.category_sharp,
                  color: Color(0xFF61F4E8),
                ),
                title: Text(
                  'Categories',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilterHelper(
                        field: 'Completed',
                      ),
                    ),
                  );
                },
                leading: Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF61F4E8),
                ),
                title: AutoSizeText(
                  'Completed Tasks',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                  maxLines: 1,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FilterHelper(
                        field: 'Pending',
                      ),
                    ),
                  );
                },
                leading: Icon(
                  Icons.pending_actions_outlined,
                  color: Color(0xFF61F4E8),
                ),
                title: AutoSizeText(
                  'Pending Tasks',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                  maxLines: 1,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AllTask(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.all_inbox_outlined,
                  color: Color(0xFF61F4E8),
                ),
                title: AutoSizeText(
                  'View All Tasks',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
