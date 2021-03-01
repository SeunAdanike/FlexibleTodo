import 'package:flexibletodo/UIs/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        child: Stack(children: <Widget>[
          Positioned(
            top: -115,
            left: -85,
            child: Container(
              width: 204,
              height: 201,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 10,
                ),
                borderRadius: BorderRadius.all(Radius.elliptical(204, 201)),
              ),
            ),
          ),
          Positioned(
            top: -115,
            left: -85,
            child: Container(
              width: 164.41787719726562,
              height: 162,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 10,
                ),
                borderRadius: BorderRadius.all(
                    Radius.elliptical(164.41787719726562, 162)),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/images/todo.svg',
                    ),
                  ),
                ),
                Text(
                  'Welcome to your flexible task companion!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Divider(
                  height: 50,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/Signup');
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 12, 70, 12),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -115,
            right: -85,
            child: Container(
              width: 204,
              height: 201,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 10,
                ),
                borderRadius: BorderRadius.all(Radius.elliptical(204, 201)),
              ),
            ),
          ),
          Positioned(
            bottom: -115,
            right: -85,
            child: Container(
              width: 164.41787719726562,
              height: 162,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 10,
                ),
                borderRadius: BorderRadius.all(
                    Radius.elliptical(164.41787719726562, 162)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
