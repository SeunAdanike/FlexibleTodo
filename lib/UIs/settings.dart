import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DateTime pageGreet;

  @override
  void initState() {
    pageGreet = DateTime.now();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: MenuBar(
        isProfile: true,
        sizeProfile: 36,
      ),
      body: Stack(
        children: [
          EdgeDesign(),
          Padding(
            padding: const EdgeInsets.only(
              top: 55.0,
              bottom: 38,
              right: 15,
              left: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat.yMMMMEEEEd().format(pageGreet)}',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage(
                          'assets/images/Foyeke.jpg',
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Name',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Tito Funmi',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 43,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Divider(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Email',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AutoSizeText(
                                      'titofunmi@aol.com',
                                      maxLines: 2,
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 28,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Divider(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Password',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AutoSizeText(
                                      '********************',
                                      maxLines: 2,
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 22,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Divider(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'OverallTask Progress',
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AutoSizeText(
                                      '60% Task Completed',
                                      maxLines: 2,
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 28,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
