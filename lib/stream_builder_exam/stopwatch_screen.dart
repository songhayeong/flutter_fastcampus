import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_example/stream_builder_exam/bloc/stopwatch_bloc.dart';
import 'package:sliver_example/stream_builder_exam/util/utils.dart';

class StopWatchScreen extends StatelessWidget {
  const StopWatchScreen({super.key});
  //bloc StopwatchStarted -> 이 부분을 bloc에서 처리해서 ui 및 business logic 분리
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
            // bloc으로 state 처리 되는 부분을 bloc builder로 구현
            // 부모 위젯 tree에 bloc을 wrapping 해줌으로써 상태처리 가능.
            child: BlocBuilder<StopwatchBloc, StopwatchState>(
              builder: (context, state) => Text(
                formatElapsedTime(state.elapsedTime),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<StopwatchBloc, StopwatchState>(
              builder: (context, state) => ListView.builder(
                itemCount: state.laps.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text("Lap ${index + 1} : ${state.laps[index]}"),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchStarted()),
            tooltip: '시작',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchStopped()),
            tooltip: '정지',
            child: const Icon(Icons.stop),
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchReset()),
            tooltip: '초기화',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<StopwatchBloc>().add(const StopwatchRecorded()),
            tooltip: '랩 기록',
            child: const Icon(Icons.flag),
          ),
        ],
      ),
    );
  }
}
