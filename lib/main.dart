import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/email/email_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/name/name_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/pages/step_one.dart';
import 'package:sliver_example/examples.dart';
import 'package:sliver_example/future_builder_exam/ex_1.dart';
import 'package:sliver_example/inherited_widget_exam/ex_1.dart';
import 'package:sliver_example/inherited_widget_exam/ex_2.dart';
import 'package:sliver_example/stream_builder_exam/bloc/stopwatch_bloc.dart';
import 'package:sliver_example/stream_builder_exam/ex_1.dart';
import 'package:sliver_example/todo_cache_exam/api/api_service.dart';
import 'package:sliver_example/todo_cache_exam/data/todo_repository.dart';
import 'package:sliver_example/todo_cache_exam/model/todo.dart';
import 'package:sliver_example/todo_cache_exam/todo_screen.dart';
import 'package:sliver_example/stream_builder_exam/stopwatch_screen.dart';
import 'package:dio/dio.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PracticeListPage(),
      initialRoute: '/',
      routes: {
        '/sliver': (context) => const SliverExampleNavigatorList(),
        '/clock': (context) => const ClockScreen(),
        '/stop_watch_with_bloc': (context) => BlocProvider<StopwatchBloc>(
              create: (context) => StopwatchBloc(),
              child: const StopWatchScreen(),
            ),
        '/future_demo': (context) => const FutureBuilderExample1(),
        '/counter_inherited': (context) => const CounterInheritedExample(),
        '/user_setting_inherited': (context) => const InheritedWidgetExample2(),
        '/todo': (context) => ToDoScreen(
              repository: ToDoRepository(
                ApiService(
                  Dio(),
                  baseUrl: Platform.isAndroid
                      ? 'http://10.0.2.2:3000'
                      : 'http://localhost:3000',
                ),
                Hive.box<ToDo>('todoBox'),
              ),
            ),
        '/register_bloc_page': (context) => const RegistrationPage(),
      },
    );
  }
}

final List<Map<String, dynamic>> _examples = [
  {'title': 'SliverAppBar', 'widget': const SliverAppBarExample()},
  {
    'title': 'SliverPersistentHeader',
    'widget': const SliverPersistentHeaderExample()
  },
  {'title': 'SliverPadding', 'widget': const SliverPaddingExample()},
  {
    'title': 'SliverToBoxAdapter',
    'widget': const SliverToBoxAdapterExample(),
    // 일반 위젯을 슬라이버 스크롤 내부에 넣을수 있게 해주는 기능
  }
];

class PracticeListPage extends StatelessWidget {
  const PracticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fastcampus practice'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sliver');
            },
            child: const Text('SliverExampleNavigatorList'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/clock');
            },
            child: const Text('Clock Stream'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/stop_watch_with_bloc');
            },
            child: const Text('Stop Watch Stream Builder'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/future_demo');
            },
            child: const Text('Future Builder Demo'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/counter_inherited');
            },
            child: const Text('Counter Inherited Widget'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user_setting_inherited');
            },
            child: const Text('User Setting Inherited Widget'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/todo');
            },
            child: const Text('To Do List'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register_bloc_page');
            },
            child: const Text('Register Bloc'),
          ),
        ],
      ),
    );
  }
}

class SliverExampleNavigatorList extends StatelessWidget {
  const SliverExampleNavigatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "sliver examples",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.primaries.first,
      ),
      body: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(_examples[index]['title']),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _examples[index]['widget'],
                ));
          },
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (context) => EmailBloc(),
                          ),
                        ], child: const StepOne())));
          },
          child: const Text(
            'Start Registration',
          ),
        ),
      ),
    );
  }
}
