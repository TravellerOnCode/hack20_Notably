import 'package:flutter/material.dart';

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
                height: 50,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.play_arrow,
                      size: 28,
                      color: Colors.white,
                    ),
                  ],
                )),
            Container(),
          ],
        ),
      ),
    );
  }
}
