import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

// void main() => runApp(MyApp());
String _formatTime(int value) {
  return value.toString().padLeft(2, '0');
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  TextEditingController _hoursController = TextEditingController(text: "");
  TextEditingController _minutesController = TextEditingController(text: "");
  TextEditingController _secondsController = TextEditingController(text: "");
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _totalSeconds = 0;
  Timer? _timer;
  bool _isPaused = false;
  int _pausedSeconds = 0;
  final _focusNode = FocusNode();
  void _startTimer() {
    setState(() {
      _totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
      _pausedSeconds = _totalSeconds;
      _isPaused = false;
      widget._hoursController.text = "";
      widget._minutesController.text = "";
      widget._secondsController.text = "";
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_totalSeconds <= 0) {
        _timer?.cancel();
        return;
      }

      if (_isPaused) {
        return;
      }

      setState(() {
        _totalSeconds--;
        _hours = _totalSeconds ~/ 3600;
        _minutes = (_totalSeconds % 3600) ~/ 60;
        _seconds = _totalSeconds % 60;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _totalSeconds = 0;
      widget._hoursController.text = "";
      widget._minutesController.text = "";
      widget._secondsController.text = "";
    });
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _totalSeconds = 0;
      _isPaused = false;
      _pausedSeconds = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   '${_formatTime(_hours)} : ${_formatTime(_minutes)} : ${_formatTime(_seconds)}',
            //   style: TextStyle(fontSize: 50),
            // ),
            CircularPercentIndicator(
              radius: 150,
              lineWidth: 20,
              percent:
                  _totalSeconds / (_hours * 3600 + _minutes * 60 + _seconds),
              center: Text(
                '${_formatTime(_hours)}:${_formatTime(_minutes)}:${_formatTime(_seconds)}',
                style: TextStyle(fontSize: 20),
              ),
              progressColor: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Hours'),
                    controller: widget._hoursController,
                    // focusNode: _focusNode,
                    onChanged: (value) {
                      setState(() {
                        _hours = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Minutes'),
                    // focusNode: _focusNode,
                    controller: widget._minutesController,
                    onChanged: (value) {
                      setState(() {
                        _minutes = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Seconds'),
                    // focusNode: _focusNode,
                    controller: widget._secondsController,
                    onChanged: (value) {
                      setState(() {
                        _seconds = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _startTimer,
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start'),
                ),
                ElevatedButton.icon(
                  onPressed: _isPaused ? _resumeTimer : _pauseTimer,
                  icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                  label: Text('Pause'),
                ),
                ElevatedButton.icon(
                  onPressed: _stopTimer,
                  icon: Icon(Icons.stop),
                  label: Text('Stop'),
                ),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: Icon(Icons.refresh),
                  label: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
