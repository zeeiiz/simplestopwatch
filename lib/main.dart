import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int _elapsedTime = 0; // Waktu yang telah berlalu dalam detik
  bool _isRunning = false; // Status stopwatch
  Timer? _timer; // Timer untuk menghitung waktu

  void _startStopwatch() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime++;
        });
      });
    }
  }

  void _stopStopwatch() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
    }
  }

  void _resetStopwatch() {
    _stopStopwatch();
    setState(() {
      _elapsedTime = 0;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60) % 60;
    final hours = seconds ~/ 3600;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch Faiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_elapsedTime),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? null : _startStopwatch,
                  child: Text('Mulai'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? _stopStopwatch : null,
                  child: Text('Berhenti'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}