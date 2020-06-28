import 'package:flutter/material.dart';
//import 'package:notably/speech_to_text.dart';
import 'package:notably/text_editor.dart';
import 'package:notably/speech_to_text.dart';


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff121212),
        backgroundColor: Color(0xff121212),
        // textTheme: TextTheme(headline1: )
      ),
      home: RecordScreen(),
    ),
  );
}

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        // color: Color(0xffe0e5ec),
        color: theme.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(163, 177, 198, 0.6),
                      offset: Offset(-3, -3),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      offset: Offset(3, 3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   RaisedButton (
            onPressed: () {
              Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => SpeechToText()),
              MaterialPageRoute(builder: (context) => TextEditor()),
            
            );
            },
            child: Text(
              'Go',
              style: TextStyle (
                fontSize: 20,
                color: Colors.black
              ),
            )
          ),
          RaisedButton (
            onPressed: () {
              Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => SpeechToText()),
              MaterialPageRoute(builder: (context) => SpeechConvertor()),
            
            );
            },
            child: Text(
              'Speak',
              style: TextStyle (
                fontSize: 20,
                color: Colors.black
              ),
            )
          )
                  ],
                )),
            Container(

            ),
          ],
        ),
      ),
    );
  }
}
