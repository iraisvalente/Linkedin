import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

double collapsableHeight = 0.0;
Color selected = Color(0xffffffff);
Color notSelected = Color(0xafffffff);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
