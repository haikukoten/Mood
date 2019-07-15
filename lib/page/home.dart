import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon/data/mood.dart';
import 'package:moon/page/images_grid.dart';
import 'package:moon/page/mood_card.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(isInitialRoute: true)
class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _random = Random(DateTime.now().millisecond);
  int _index = 0;
  double _lastPosition = -1;
  PageController _pageController;
  List<Color> colors;

  Color get _randomColor =>
      Color.fromARGB(255, _random.nextInt(255), _random.nextInt(255), _random.nextInt(255));

  double get page {
    try {
      debugPrint("page=${_pageController.page}");
      debugPrint("index=${_pageController.page.floor()}");
      return _pageController.page;
    } catch (e) {
      return 0.0;
    }
  }

  double get parallaxOffset {
    var p = page;
    p = _lastPosition >= p ? p.floor() - p : -(p.floor() - p);
    debugPrint("offset=$p");
    return p;
  }

  Color get currentColor => Color.lerp(
      colors[page.toInt()], colors[(page.toInt() + 1) % colors.length], parallaxOffset);

  void _jumpTo(int index) {
    if (index != _index) {
      setState(() => _index = index);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    colors = List.generate(
        20, (index) => Color.alphaBlend(Colors.white.withOpacity(0.4), _randomColor));
    _pageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () => _jumpTo(0)),
            IconButton(icon: Icon(Icons.trip_origin), onPressed: () => _jumpTo(1)),
            IconButton(icon: Icon(Icons.settings_ethernet), onPressed: () => _jumpTo(2)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          Container(
            color: currentColor,
            child: Consumer<MoodProvider>(
              builder: (BuildContext context, MoodProvider value, Widget child) =>
                  PageView.builder(
                controller: _pageController,
                itemCount: value.documents.length,
                itemBuilder: (BuildContext context, int index) => MoodCard(
                  parent: context,
                  index: index,
                  color: colors[index % colors.length],
                ),
              ),
            ),
          ),
          // Container(
          //   child: Center(
          //     child: Text("2"),
          //   ),
          // ),
          
          ImagesGridScreen(),
          Container(
            child: Center(
              child: Text("3"),
            ),
          ),
        ],
      ),
    );
  }
}
