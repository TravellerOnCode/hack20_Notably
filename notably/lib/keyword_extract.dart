import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String data;
Future<Album> fetchAlbum(String title) async {
  print(title);
  final http.Response response = await http.post(
    //'https://jsonplaceholder.typicode.com/albums',
    'https://keywordextractor.herokuapp.com/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'text': title,
      'key':'AQUAMANNOTELY@69',
    }),
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch response');
  }
}


class Album {
  //final int results;
  //final String wordscount;
  final String title;

  //Album({this.title, this.wordscount});
  Album({this.title});


  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      //results: json['results'],
      //wordscount: (json['results']['count']).toString(), 
      title: ((json['results']['results']).toString())
    );
  }
}

//void main() => runApp(MyApp());

class DisplayResponse extends StatefulWidget {
  //DisplayResponse({Key key}) : super(key: key);
  final String value;
  DisplayResponse({Key key, @required this.value}) : super(key: key);
  

  @override
  _DisplayResponse createState() => _DisplayResponse(value);
}

class _DisplayResponse extends State<DisplayResponse> {

  Future<void> _launched;
//String _phone = '';

Future<void> _launchInBrowser(String url) async {
  print('launch in browser called !');
    if (await canLaunch(url)) {
      await launch(
        url,
        //forceSafariVC: false,
        //forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

Future<Album> futureAlbum;
  String value;
  _DisplayResponse(this.value);
  TextEditingController _controller;

  
  
  @override
  /*
  void initState() { 
    super.initState();
    data = value;
    print(data);
    futureAlbum = fetchAlbum(data);
  }*/
  void initState() {
    super.initState();
    data = value;
    print(data);
    futureAlbum = fetchAlbum(data);
    _controller = TextEditingController(
      text: ""
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data.title,style: new TextStyle(fontSize: 80.0));
                return Center( 
                  heightFactor: 20,
                  widthFactor: 40,
                child: new ListView(
                  padding: const EdgeInsets.fromLTRB(20,50,10,10),
                  children: <Widget>[
                    Text('Top Words',style: new TextStyle(fontSize: 40.0)),
                    Text(snapshot.data.title,style: new TextStyle(fontSize: 20.0)),
                    //Text('Word Count',style: new TextStyle(fontSize: 40.0)),
                    //Text(snapshot.data.wordscount,style: new TextStyle(fontSize: 60.0)),
                    Center(
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Type your keyword here"
          ),
          maxLines: null,
          autocorrect: true,
          controller: _controller,
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  content: Text('You typed "$value".'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          ),
        ),
        RaisedButton(
                onPressed: () => setState(() {
                  Text t = Text(_controller.text);
                   String s = t.data;
                   String urllink = 'https://www.google.com/search?q=' +  s;
                  _launched = _launchInBrowser(urllink);
                }),
                child: Text(
              'Make a Google Search',
              style: TextStyle (
                fontSize: 20,
                color: Colors.black
              ),
            ),
              ),
          
        FutureBuilder<void>(future: _launched, builder: _launchStatus),
                  ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}