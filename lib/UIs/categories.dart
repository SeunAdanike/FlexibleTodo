import 'package:flexibletodo/UIs/filterScreen.dart';
import 'package:flexibletodo/models/categories.dart';
import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flexibletodo/widgets/edgeDesign.dart';
import 'package:flexibletodo/widgets/menubar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/Foyeke.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello, ',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              'Tito',
                              style: GoogleFonts.ubuntu(
                                color: Colors.yellowAccent,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Good morning!',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '6th February, 2020',
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
