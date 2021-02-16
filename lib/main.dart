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
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Welcome(),
        );
  }
}
