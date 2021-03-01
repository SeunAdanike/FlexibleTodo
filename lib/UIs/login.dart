import 'package:flexibletodo/UIs/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
   static const String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello!',
                            style: GoogleFonts.ubuntu(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            'Good morning',
                            style: GoogleFonts.ubuntu(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SvgPicture.asset(
                    'assets/images/login.svg',
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w400,
                            ),
                            hintText: 'Enter your registered email address',
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                        ),
                        Divider(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w400,
                            ),
                            hintText: 'Enter your Password',
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 30,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 12, 100, 12),
                    child: Text(
                      'Login',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A new user? ',
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.ubuntu(
                          fontSize: 18, color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
                Divider(
                  height: 5,
                ),
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
