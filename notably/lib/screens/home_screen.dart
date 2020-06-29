import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notably/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notably/screens/screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Doc { note, folder }


class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);


  final tags = [
    {
      'title': 'Python',
      'type': Doc.folder,
    },
    {
      'title': 'Dart',
      'type': Doc.folder,
    },
    {
      'title': 'Flutter',
      'type': Doc.note,
    },
    {
      'title': 'Cloud',
      'type': Doc.folder,
    },
    {
      'title': 'Physics',
      'type': Doc.folder,
    },
    {
      'title': 'Maths',
      'type': Doc.note,
    },
    {
      'title': 'Physics',
      'type': Doc.note,
    },
    {
      'title': 'Bio',
      'type': Doc.folder,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteScreen(),
          ),
        ),
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: theme.primaryColor,
      ),
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        color: theme.backgroundColor,
        padding: EdgeInsets.only(
          top: 40,
          left: 20,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('notes').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return Stack(
                    children: <Widget>[
                      CustomPaint(
                        painter:
                            StructurePainter(snapshot.data.documents.length),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () =>
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                              LoggedOut(),
                            ),
                            child: Container(
                              // height: 25,
                              color: theme.backgroundColor,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '/',
                                    style: theme.textTheme.headline2,
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.folder,
                                    color: theme.buttonColor,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Notes',
                                    style: theme.textTheme.headline2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ...snapshot.data.documents
                              .map((doc) => tagBar(
                                    title: doc['title'],
                                    type: Doc.folder,
                                    text: doc['text'],
                                    theme: theme,
                                    context: context,
                                  ))
                              .toList(),
                        ],
                      ),
                    ],
                  );
              }
            }),
      ),
    );
  }

  Widget tagBar(
      {String title,
      Doc type,
      String text,
      ThemeData theme,
      BuildContext context}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteScreen(
            data: text,
          ),
        ),
      ),
      child: Container(
        color: theme.backgroundColor,
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 50),
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: <Widget>[
            Text(
              '/',
              style: theme.textTheme.headline2,
            ),
            SizedBox(width: 8),
            Icon(
              FontAwesomeIcons.folder,
              // type == Doc.folder
              //     ? FontAwesomeIcons.folder
              //     : FontAwesomeIcons.stickyNote,
              color: theme.buttonColor,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

class StructurePainter extends CustomPainter {
  final length;

  StructurePainter(this.length);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = Colors.white70;

    final base = 16.0;

    canvas.drawLine(
        Offset(30.0, base), Offset(30.0, base + 44 * length), paint);

    for (int i = 1; i <= length; i++) {
      canvas.drawLine(
          Offset(30.0, base + 44 * i), Offset(70.0, base + 44 * i), paint);
    }
  }

  @override
  bool shouldRepaint(StructurePainter oldDelegate) => false;
}

