import 'package:flutter/material.dart';
import 'package:sliver_example/examples.dart';
import 'package:sliver_example/examples/ex_3_sliver_padding.dart';

void main() {
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
      home: const SliverExampleNavigatorList(),
    );
  }
}

final List<Map<String, dynamic>> _examples = [
  {'title': 'SliverAppBar', 'widget': const SliverAppBarExample()},
  {
    'title':'SliverPersistentHeader', 'widget':const SliverPersistentHeaderExample()
  },
  {
    'title':'SliverPadding',
    'widget':const SliverPaddingExample()
  },
  {
    'title' : 'SliverToBoxAdapter',
    'widget':const SliverToBoxAdapterExample(), // 일반 위젯을 슬라이버 스크롤 내부에 넣을수 있게 해주는 기능
  }
];

class SliverExampleNavigatorList extends StatelessWidget {
  const SliverExampleNavigatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
