import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {

  final Stopwatch _stopwatch = Stopwatch();
  final Duration _tick = const Duration(milliseconds: 10); // 10 밀리초 간격

  late Timer _timer;
  late StreamController<int> _streamController;

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer t) {
        _streamController.add(_stopwatch.elapsedMilliseconds);
        // stream에 지속적으로 이벤트를 발생시켜 streamBuilder를 사용할 수 있게 구현
      });
    }
  }

  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>();
  }

  @override // widget 종료 될 때
  void dispose() {
    _timer.cancel();
    _streamController.close(); // 메모리 누수 대비 앱 성능을 생각한다면 필히 잘 써야 할듯
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' 스톱 워치 '),
      ),
      body: Center(
          child: StreamBuilder<int>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              final milliseconds = snapshot.data ?? 0;

              final hours = ((milliseconds / (1000 * 60 * 60)) % 24).floor();
              final minutes = ((milliseconds / (1000 * 60)) % 60).floor();
              final seconds = ((milliseconds / 1000) % 60).floor();
              final millisecondsDisplay = (milliseconds % 1000).floor();

              return Text(
                '${hours.toString().padLeft(2, '0')}:${minutes.toString()
                    .padLeft(2, '0')}:${seconds.toString().padLeft(
                    2, '0')}:${millisecondsDisplay.toString().padLeft(2, '0')}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
              );
            },
          )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _startTimer,
            tooltip: '시작',
            child: Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: _stopTimer,
            tooltip: '정지',
            child: Icon(Icons.stop),
          ),
          FloatingActionButton(
            onPressed: _resetTimer,
            tooltip: '초기화',
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
