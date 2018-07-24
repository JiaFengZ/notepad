import 'package:flutter/material.dart';
import 'package:notepad/home.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '备忘录',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new MyHomePage(title: '备忘录'),
    );
  }
}
