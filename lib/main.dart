import 'package:flexibletodo/UIs/login.dart';
import 'package:flexibletodo/UIs/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF06748C),
        accentColor: Color(0xFFE5FDFB),
        primaryColorLight: Color(0xFF5FA2B0),
        highlightColor: Color(0xfFF06748C),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(),
    );
  }
}
