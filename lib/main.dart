import 'package:flexibletodo/UIs/dashboard.dart';
import 'package:flexibletodo/UIs/details.dart';
import 'package:flexibletodo/UIs/login.dart';
import 'package:flexibletodo/UIs/signup.dart';
import 'package:flexibletodo/UIs/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF06748C),
        accentColor: Color(0xFFE5FDFB),
        primaryColorLight: Color(0xFF5FA2B0),
        highlightColor: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Dash(),
      initialRoute: '/',
      routes: {
        '/Login': (context) => Login(),
        '/Dash': (context) => Dash(),
        '/Signup': (context) => SignUp()
      },
    );
  }
}
