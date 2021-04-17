import 'package:flexibletodo/UIs/filterScreen.dart';
import 'package:flexibletodo/models/categories.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  DateTime pageGreet;

  int hour;

  int minute;

  @override
  void initState() {
    pageGreet = DateTime.now();
    hour = pageGreet.hour;
    minute = pageGreet.minute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      extendBody: true,
      bottomNavigationBar: MenuBar(
        isHome: true,
        sizeHome: 36,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          EdgeDesign(),
          Padding(
            padding: const EdgeInsets.only(
              top: 38.0,
              left: 15,
              right: 15,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ((hour >= 0 && hour <= 11) && minute <= 59)
                              ? 'Hello there!'
                              : ((hour > 11 && hour <= 16) && minute <= 59)
                                  ? 'Hey there!'
                                  : 'Hi there!',
                          style: GoogleFonts.ubuntu(
                            fontStyle: FontStyle.italic,
                            color: Colors.yellowAccent,
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          ((hour >= 0 && hour <= 11) && minute <= 59)
                              ? 'Good Morning!'
                              : ((hour > 11 && hour <= 16) && minute <= 59)
                                  ? 'Good Afternoon!'
                                  : 'Good Evening!',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '${DateFormat.yMMMMEEEEd().format(pageGreet)}',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      'Tasks Categories',
                      style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '(${CATEGORIES.length})',
                        style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 22.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FilterHelper(
                                  field: CATEGORIES[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 18.0,
                                bottom: 18,
                                right: 20,
                                left: 20,
                              ),
                              child: Text(
                                CATEGORIES[index],
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: CATEGORIES.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
