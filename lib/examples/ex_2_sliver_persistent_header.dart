import 'package:flutter/material.dart';

class SliverPersistentHeaderExample extends StatelessWidget {
  const SliverPersistentHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MyHeaderDelegate(),
            pinned: true, // header 고정
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 100,
              (context, index) => ListTile(
                title: Text("item #$index"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  // TODO: implement maxExtent
  double get maxExtent => 150.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 60.0;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'SliverPersistentHeader',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
