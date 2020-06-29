import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notably/image_ocr.dart';
import 'package:notably/speech_to_text.dart';
import 'package:notably/keyword_extract.dart';

class NoteScreen extends StatefulWidget {
  String data;
  NoteScreen({this.data = ''});

  @override
  _NoteScreenState createState() => _NoteScreenState(data);
}

class _NoteScreenState extends State<NoteScreen> {
  String data;

  _NoteScreenState(this.data);

  List<Map<String, Object>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': TextEditor(data: data),
        'title': 'Editor',
      },
      {
        'page': ImageOcrPage(),
        'title': 'Image OCR',
      },
      {
        'page': SpeechConvertor(),
        'title': 'Speech Convertor',
      },
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.buttonColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.edit),
            title: Text('Edit'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.image),
            title: Text('Image'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.microphone),
            title: Text('Record'),
          ),
        ],
      ),
    );
  }
}

class TextEditor extends StatefulWidget {
  String data;
  TextEditor({this.data = ''});

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  TextEditingController note;
  TextEditingController title = TextEditingController();
  final documentRef = Firestore.instance.collection('notes').document();
  @override
  initState() {
    super.initState();
    note = TextEditingController(text: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    
    return Stack(
      children: <Widget>[
        Container(
          height: mediaQuery.size.height - 50,
          width: mediaQuery.size.width,
          color: theme.backgroundColor,
          padding: EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: title,
                  onChanged: (val) {
                    setState(() {
                      title.text = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: theme.backgroundColor,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 20),
                  ),
                  style: theme.textTheme.headline2,
                ),
                TextField(
                  controller: note,
                  // onChanged: (val) {
                  //   setState(() {
                  //     print(val);
                  //     note.text = val;
                  //     note.
                  //   });
                  // },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: theme.backgroundColor,
                    hintText: 'Enter Notes',
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 20),
                  ),
                  maxLines: null,
                  style: theme.textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 0,
          child: Container(
            height: 80,
            width: 80,
            // padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.grey[800],
            ),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.save,
                color: theme.primaryColor,
              ),
              iconSize: 40,
              onPressed: () {
                print(title.text);
                print(note.text);
                documentRef.setData({
                  'title': title.text,
                  'text': note.text,
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayResponse(value: note.text)));
            },
            child: Container(
              height: 80,
              width: 80,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey[800],
              ),
              child: Center(
                child: Text(
                  'TAGS',
                  style: theme.textTheme.headline2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
