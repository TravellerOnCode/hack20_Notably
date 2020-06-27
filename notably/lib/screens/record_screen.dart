import 'package:flutter/material.dart';
import 'dart:math';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _isPlayTapped;

  @override
  void initState() {
    super.initState();
    _isPlayTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
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
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(75),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff101144),
                    offset: Offset(3, 3),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: Color(0xff25262b),
                    offset: Offset(-3, -3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color(0xff1e1f24),
                ),
                child: Icon(
                  Icons.mic,
                  color: theme.accentColor,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                '00:00:00',
                style: theme.textTheme.headline1,
              ),
            ),
            GestureDetector(
              onTap: !_isPlayTapped ?  () {
                setState(() {
                  _isPlayTapped = true;
                });
              } : null,
              child: Container(
                height: 50,
                width: 150,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  gradient: !_isPlayTapped
                      ? LinearGradient(
                          colors: [Color(0xff1c1d21), Color(0xff17181c)],
                          transform: GradientRotation(pi / 180 * 145),
                        )
                      : null,
                  boxShadow: !_isPlayTapped
                      ? [
                          BoxShadow(
                            color: Color(0xff101144),
                            offset: Offset(3, 3),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0xff25262b),
                            offset: Offset(-3, -3),
                            blurRadius: 4,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Color(0xffcbcbcb),
                            offset: Offset(3, 3),
                            blurRadius: 4,
                            spreadRadius: -6,
                          ),
                          BoxShadow(
                            color: Color(0xffffffff),
                            offset: Offset(-3, -3),
                            blurRadius: 4,
                            spreadRadius: -6,
                          ),
                        ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Start',
                      style: theme.textTheme.headline2,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.play_arrow,
                      size: 28,
                      color: theme.buttonColor,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _isPlayTapped
                      ? () {
                          setState(() {
                            _isPlayTapped = false;
                          });
                        }
                      : null,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      gradient: _isPlayTapped
                          ? LinearGradient(
                              colors: [Color(0xff1c1d21), Color(0xff17181c)],
                              transform: GradientRotation(pi / 180 * 145),
                            )
                          : null,
                      boxShadow: _isPlayTapped
                          ? [
                              BoxShadow(
                                color: Color(0xff101144),
                                offset: Offset(3, 3),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Color(0xff25262b),
                                offset: Offset(-3, -3),
                                blurRadius: 4,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Color(0xffcbcbcb),
                                offset: Offset(3, 3),
                                blurRadius: 4,
                                spreadRadius: -6,
                              ),
                              BoxShadow(
                                color: Color(0xffffffff),
                                offset: Offset(-3, -3),
                                blurRadius: 4,
                                spreadRadius: -6,
                              ),
                            ],
                    ),
                    child: Icon(
                      Icons.pause,
                      size: 28,
                      color: theme.buttonColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _isPlayTapped ? () {} : null,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      gradient: _isPlayTapped
                          ? LinearGradient(
                              colors: [Color(0xff1c1d21), Color(0xff17181c)],
                              transform: GradientRotation(pi / 180 * 145),
                            )
                          : null,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: _isPlayTapped
                          ? [
                              BoxShadow(
                                color: Color(0xff101144),
                                offset: Offset(3, 3),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Color(0xff25262b),
                                offset: Offset(-3, -3),
                                blurRadius: 4,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Color(0xffcbcbcb),
                                offset: Offset(3, 3),
                                blurRadius: 4,
                                spreadRadius: -6,
                              ),
                              BoxShadow(
                                color: Color(0xffffffff),
                                offset: Offset(-3, -3),
                                blurRadius: 4,
                                spreadRadius: -6,
                              ),
                            ],
                    ),
                    child: Icon(
                      Icons.stop,
                      size: 28,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
