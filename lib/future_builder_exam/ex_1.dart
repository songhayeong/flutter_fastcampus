import 'package:flutter/material.dart';

class FutureBuilderExample1 extends StatelessWidget {
  const FutureBuilderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder Demo'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            // snapshot은 future에 대한 실질적인 정보를 담고있는 영역
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error : ${snapshot.error}");
            } else {
              return Text(snapshot.data ?? '데이터 없음');
            }
          },
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return '데이터 로드 완료';
  }
}
