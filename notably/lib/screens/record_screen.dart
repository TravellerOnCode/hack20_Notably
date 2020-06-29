import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io' as io;
import 'dart:async';
import 'package:file/local.dart';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:notably/blocs/theme_bloc/theme_bloc.dart';


class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _isPlayTapped;
  FlutterAudioRecorder _recorder;
  Recording _recording;
  Timer _timer;
  int _count = 0;

  List<double> values = [for (var i = 0; i < 50; i++) 0];




  @override
  void initState() {
    super.initState();
    _isPlayTapped = false;
    Future.microtask(() => _prepare());
  }

  Future _init() async {
    String customPath = '/AUD-';
    io.Directory appDocDirectory = await getApplicationDocumentsDirectory();

    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();
    print(customPath);

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.AAC, sampleRate: 22050);
    await _recorder.initialized;
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      await _init();
      var result = await _recorder.current();
      setState(() {
        _recording = result;
      });
    } else {
      print('Permission required!');
    }
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _timer = timer;
        _count = (_count + 1) % 100;
        if (_count % 10 == 0) {
          for (var i = 0; i < values.length - 1; i++) {
            values[i] = values[i + 1];
          }
          values[values.length - 1] = Random().nextDouble() * 0.8;
        }
      });
    });
  }

  Future _pauseRecording() async {
    await _recorder.pause();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });
    _timer.cancel();
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _timer.cancel();

    setState(() {
      _recording = result;
    });

    _prepare();
    io.File file = LocalFileSystem().file(result.path);
    print("File length: ${await file.length()}");
  }

  String _formatDurationString(String dur) {
    if (dur == null) {
      return null;
    }
    return dur.indexOf('.') == -1 ? null : dur.substring(0, dur.indexOf('.'));
  }

  @override
  Widget build(BuildContext context) {
    final _shadowBox = BlocProvider.of<ThemeBloc>(context).state.shadows;
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
                  _shadowBox[0],
                  _shadowBox[1],
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
            if (_isPlayTapped)
              Container(
                width: 400,
                height: 100,
                margin: EdgeInsets.all(20),
                color: Color(0xff1e1f24),
                child: CustomPaint(painter: RecordPainter(values)),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                _formatDurationString(
                        _recording?.duration.toString() ?? null) ??
                    '00:00:00',
                style: theme.textTheme.headline1,
              ),
            ),
            GestureDetector(
              onTap: !_isPlayTapped
                  ? () async {
                      setState(() {
                        _isPlayTapped = true;
                      });
                      _startRecording();
                    }
                  : null,
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
                          _shadowBox[0],
                          _shadowBox[1],
                        ]
                      : [
                          _shadowBox[2],
                          _shadowBox[3],
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
                            _pauseRecording();
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
                              _shadowBox[0],
                              _shadowBox[1],
                            ]
                          : [
                              _shadowBox[2],
                              _shadowBox[3],
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
                  onTap: (_recording?.duration ?? Duration(milliseconds: 0))
                              .inMilliseconds >
                          0
                      ? () {
                          setState(() {
                            _isPlayTapped = false;
                          });
                          _stopRecording();
                        }
                      : null,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      gradient: (_recording?.duration ??
                                      Duration(milliseconds: 0))
                                  .inMilliseconds >
                              0
                          ? LinearGradient(
                              colors: [Color(0xff1c1d21), Color(0xff17181c)],
                              transform: GradientRotation(pi / 180 * 145),
                            )
                          : null,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow:
                          (_recording?.duration ?? Duration(milliseconds: 0))
                                      .inMilliseconds >
                                  0
                              ? [
                                  _shadowBox[0],
                                  _shadowBox[1],
                                ]
                              : [
                                  _shadowBox[2],
                                  _shadowBox[3],
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

class RecordPainter extends CustomPainter {
  final values;

  RecordPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawLine(Offset(20, size.height * 0.9),
        Offset(size.width - 20.0, size.height * 0.9), paint);
    canvas.drawLine(Offset(20, size.height * 0.1),
        Offset(size.width - 20.0, size.height * 0.1), paint);
    canvas.drawLine(Offset(size.width - 20, size.height * 0.1),
        Offset(size.width - 20, size.height * 0.9), paint);
    canvas.drawCircle(Offset(size.width - 20, size.height * 0.1), 5, paint);
    canvas.drawCircle(Offset(size.width - 20, size.height * 0.9), 5, paint);

    final step = (size.width - 40) / (values.length);

    paint.color = Colors.red;
    for (var i = 0; i < values.length; i++) {
      canvas.drawLine(Offset(20 + step * i, size.height / 2 * (1 - values[i])),
          Offset(20 + step * i, size.height / 2 * (1 + values[i])), paint);
    }
  }

  @override
  bool shouldRepaint(RecordPainter oldDelegate) => false;
}
