import 'package:flutter/material.dart';

import 'package:notably/screens/screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red[300],
        accentColor: Colors.red[700],
        backgroundColor: Color(0xff1a1b1f),
        buttonColor: Colors.white70,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
          headline2: TextStyle(
            color: Colors.white70,
            fontSize: 20,
          ),
        ),
      ),
      home: RecordScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

