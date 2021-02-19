import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexibletodo/UIs/allTask.dart';
import 'package:flexibletodo/UIs/categories.dart';
import 'package:flexibletodo/UIs/filterScreen.dart';
import 'package:flexibletodo/UIs/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 28.0,
          left: 10,
          right: 10,
          bottom: 18,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/images/Foyeke.jpg',
              ),
            ),
            Divider(),
            Text(
              'Hello!',
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
            AutoSizeText(
              'Tito Funmi',
              style: GoogleFonts.ubuntu(
                color: Color(0xFFFFEA32),
                fontSize: 35,
              ),
              maxLines: 1,
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
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
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.online_prediction,
                color: Color(0xFF61F4E8),
              ),
              title: Text(
                'Sync Online',
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
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
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              leading: Icon(
                Icons.logout,
                color: Color(0xFF61F4E8),
              ),
              title: AutoSizeText(
                'Log Out',
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
    );
  }
}
