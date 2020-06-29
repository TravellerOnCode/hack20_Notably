import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'package:photo_view/photo_view.dart';
import 'package:notably/screens/note_screen.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

String scannedtext = "";
var imagepropeties;

// class LoadImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageOcrPage(),
//     );
//   }
// }

class ImageOcrPage extends StatefulWidget {
  //ImageOcrPage({Key key, @required this.data}) : super(key: key);

  @override
  _ImageOcrPageState createState() => _ImageOcrPageState();
}

class _ImageOcrPageState extends State<ImageOcrPage> {
  File pickedImage;

  bool isImageLoaded = false;
  final picker = ImagePicker();

  Future pickImage() async {
    var tempStore = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      //imagepropeties = decodeImageFromList(pickedImage.readAsBytesSync());
    });
    //return pickedImage;
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    //String scannedtextt = "";

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          String s = word.text;
          scannedtext = scannedtext + " " + s;
          //print(s);
        }
      }
    }

    //final data1 = Data(
    //  scannedtext: scannedtextt);
    print(scannedtext);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(data: scannedtext)),
    );
  }
  /*Future result() async {
       scannedtext = "Avijit India";
       print (scannedtext);
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    //File pickedImage_;

    //pickedImage_ = pickImage();
    return ListView(
      children: <Widget>[
        /*
        Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(pickedImage),
          fit: BoxFit.cover
        ) ,
      ),
    ),
    isImageLoaded
            ?     PhotoView(
          imageProvider: FileImage(pickedImage),
        ),
         */

        //SizedBox(height: 100.0),
        Center(
          child: Container(
            height: mediaQuery.size.height * 0.7,
            // padding: isImageLoaded ? null : EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.35),
            width: mediaQuery.size.width * 0.95,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              border: Border.all(color: theme.accentColor),
              image: isImageLoaded
                  ? DecorationImage(
                      image: FileImage(pickedImage),
                      fit: BoxFit.fill,
                    )
                  : null,
            ),
            child: !isImageLoaded
                ? RaisedButton(
                    child: Text('Pick an image'),
                    onPressed: pickImage,
                    color: theme.primaryColor,
                  )
                : null,
          ),
        ),

        SizedBox(height: 10.0),

        if (isImageLoaded)
          Container(
            margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.3),
            child: RaisedButton(
              child: Text('Pick an image'),
              onPressed: pickImage,
              color: theme.primaryColor,
            ),
          ),

        Container(
          // width: 100,
          margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.3),
          child: RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Read Text', ),
            ),
            onPressed: readText,
            color: theme.primaryColor,
          ),
        ),

        /*
        SizedBox(height: 10.0),
        RaisedButton(
          child: Text('Read Text'),
          onPressed: readText,
        ),
        RaisedButton(
          child: Text('Show Text'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        )*/
      ],
    );
  }
}

class SecondRoute extends StatelessWidget {
  Future result() async {
    scannedtext = "Avijit";
    print(scannedtext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scanned Text"),
        ),
        /*
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.blue[100],
              child: Column(
                children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                          scannedtext,
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
            );
            },
      ),
      ),*/
        body: Column(
          children: <Widget>[
            //SizedBox(height: 10.0),
            Flexible(
              child: Text(
                scannedtext,
                style: new TextStyle(fontSize: 20.0),
              ),
            ),
            FloatingActionButton(
              child: new Icon(Icons.clear),
              onPressed: () {
                scannedtext = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
                /*Text(
          scannedtext,
                    style: new TextStyle(fontSize: 20.0),
        );*/
              },
            )
          ],
        ));
  }
}
