import 'package:flutter/material.dart';
import 'package:moon/component/theme.dart';
import 'dart:math';
import 'package:moon/data/mood.dart';
import 'package:moon/component/mood_card.dart';
import 'package:provider/provider.dart';

class MoodViewScreen extends StatefulWidget {
  @override
  _MoodViewScreenState createState() => _MoodViewScreenState();
}

class _MoodViewScreenState extends State<MoodViewScreen> {
  final _random = Random(DateTime.now().millisecond);
  double _lastPosition = -1;
  PageController _pageController;
  List<Color> colors;

  Color get _randomColor => Color.fromARGB(
      255, _random.nextInt(255), _random.nextInt(255), _random.nextInt(255));

  double get page {
    try {
      return _pageController.page;
    } catch (e) {
      return 0.0;
    }
  }

  double get parallaxOffset {
    var p = page;
    p = _lastPosition >= p ? p.floor() - p : -(p.floor() - p);
    return p;
  }

  Color get currentColor => Color.lerp(colors[page.toInt()],
      colors[(page.toInt() + 1) % colors.length], parallaxOffset);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    colors = List.generate(
        20,
        (index) =>
            Color.alphaBlend(Colors.white.withOpacity(0.4), _randomColor));
    _pageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (BuildContext context, AppTheme theme, Widget child) =>
          Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: theme.currentColors,
          ),
        ),
        child: child,
      ),
      child: Container(
        // color: currentColor.withAlpha(120),
        child: Consumer<MoodProvider>(
          builder: (BuildContext context, MoodProvider value, Widget child) =>
              PageView.builder(
            controller: _pageController,
            itemCount: value.documents.length,
            itemBuilder: (BuildContext context, int index) => MoodCard(
              parent: context,
              index: index,
              color: colors[index % colors.length],
              // 视差效果
              parallaxOffset: index - page,
            ),
          ),
        ),
      ),
    );
  }
}
