import 'package:flutter/material.dart';

class CounterInheritedExample extends StatefulWidget {
  const CounterInheritedExample({super.key});

  @override
  State<CounterInheritedExample> createState() =>
      _CounterInheritedExampleState();
}

class _CounterInheritedExampleState extends State<CounterInheritedExample> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget Example'),
      ),
      body: CounterInheritedWidget(
        counter: _counter,
        increment: _incrementCounter,
        child: Center(
          child: CounterWidget(),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = CounterInheritedWidget.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("You have pushed the button this many times: "),
        Text(
          '${inheritedWidget?.counter}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ElevatedButton(
          onPressed: inheritedWidget?.increment,
          child: const Text("Increment"),
        ),
      ],
    );
  }
}

class CounterInheritedWidget extends InheritedWidget {
  final int counter;

  final Function() increment;

  const CounterInheritedWidget({
    super.key,
    required super.child,
    required this.counter,
    required this.increment,
  });

  static CounterInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  } // 부모 위젯의 context 정보를 알기 위해 provider의 근간,,

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }

}
