import 'package:email_validator/email_validator.dart';
import 'package:flexibletodo/UIs/addTask.dart';
import 'package:flexibletodo/connections.dart/database_management.dart';
import 'package:flexibletodo/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/Signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseManager _databaseManager = DatabaseManager();
  UserDetails _userDetails = UserDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(children: <Widget>[
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
              borderRadius:
                  BorderRadius.all(Radius.elliptical(164.41787719726562, 162)),
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
              borderRadius:
                  BorderRadius.all(Radius.elliptical(164.41787719726562, 162)),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 15),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SvgPicture.asset(
                      'assets/images/buddies.svg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Onboard!',
                      style: GoogleFonts.ubuntu(
                        fontSize: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'Flex is thrilled to be your companion.',
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    right: 14.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Place enter your name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email",
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Enter your registered email address',
                        ),
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
                          validator: (value) {
                            Pattern pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regex = new RegExp(pattern);
                            print(value);
                            if (value.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (!regex.hasMatch(value))
                                return 'Enter valid password';
                              else
                                return null;
                            }
                          }),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Enter your Password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Please Enter a text';
                          if (value != _passwordController.text) {
                            return 'it is not the same as password';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 30,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .95,
                  height: MediaQuery.of(context).size.height * .06,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      _userDetails = UserDetails();
                      _userDetails.id = DateTime.now().millisecondsSinceEpoch;
                      _userDetails.userName = _nameController.text;
                      var addingUser = await _databaseManager
                          .saveDetails(_userDetails.userMap());
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddTask(),
                      ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?  ',
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
