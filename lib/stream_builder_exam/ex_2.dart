import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sliver_example/stream_builder_exam/util/utils.dart';

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

  final List<String> _laps = [];

  //bloc StopwatchStarted
  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(_tick, (Timer t) {
        _streamController.add(_stopwatch.elapsedMilliseconds);
        // stream에 지속적으로 이벤트를 발생시켜 streamBuilder를 사용할 수 있게 구현
      });
    }
  }

  //bloc StopwatchStoped
  void _stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  //bloc stopwatch Reset
  void _resetTimer() {
    _stopwatch.reset();
    _streamController.add(0);
    setState(() {
      _laps.clear();
    });
  }


  //bloc stopwatch reset
  void _recordLap() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final lapTime = formatElapsedTime(milliseconds);
    setState(() {
      _laps.add(lapTime);
    });
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                final milliseconds = snapshot.data ?? 0;
                return Text(
                  formatElapsedTime(milliseconds),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) => ListTile(
                title: Text("Lap ${index + 1} : ${_laps[index]}"),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _startTimer,
            tooltip: '시작',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: _stopTimer,
            tooltip: '정지',
            child: const Icon(Icons.stop),
          ),
          FloatingActionButton(
            onPressed: _resetTimer,
            tooltip: '초기화',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: _recordLap,
            tooltip: '랩 기록',
            child: const Icon(Icons.flag),
          ),
        ],
      ),
    );
  }
}
