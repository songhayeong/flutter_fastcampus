// sealed class 란 ?

// class의 무분별한 상속을 제한 하고 싶어서 (subclassing 제한)
// 더 안전한 + 더 정확한 패턴매칭을 하고싶기 때문
// 특징 1. 다른 파일에서 접근 불가능

part of 'stopwatch_bloc.dart';

sealed class StopwatchEvent {
  const StopwatchEvent();
}

final class StopwatchStarted extends StopwatchEvent {
  const StopwatchStarted();
}

final class StopwatchStopped extends StopwatchEvent {
  const StopwatchStopped();
}

final class StopwatchReset extends StopwatchEvent {
  const StopwatchReset();
}

final class StopwatchTicked extends StopwatchEvent {
  final int elapsedTime;

  StopwatchTicked({required this.elapsedTime});
}

final class StopwatchRecorded extends StopwatchEvent {
  const StopwatchRecorded();
}