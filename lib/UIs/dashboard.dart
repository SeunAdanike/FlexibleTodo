import 'package:flexibletodo/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(   drawer: AppDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
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
            Text(
              'Completion bar',
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
