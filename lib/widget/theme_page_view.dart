import 'package:flutter/material.dart';
import 'package:moon/util.dart';

class ThemePageView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final currentThemeIndex;
  const ThemePageView({
    Key key,
    @required this.itemBuilder,
    this.itemCount,
    this.currentThemeIndex = 0,
  }) : super(key: key);

  @override
  ThemePageViewState createState() => ThemePageViewState();
}

class ThemePageViewState extends State<ThemePageView> {
  PageController _pageController;

  double get page => getPage(_pageController);
  int get leftIndex => page.floor();
  double get percent => page - leftIndex;

  final duration = const Duration(milliseconds: 600);
  final curve = Curves.ease;

  void animatedTo(int page) =>
      _pageController?.animateToPage(page, duration: duration, curve: curve);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.currentThemeIndex, viewportFraction: 0.33);
    _pageController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.itemCount,
      itemBuilder: (BuildContext context, int index) => Transform(
        child: widget.itemBuilder(context, index),
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(0.0, (page - index) * 50, 0)
          ..scale(getScale(index), getScale(index), 0),
      ),
    );
  }

  double getScale(int index) =>
      1 +
      0.2 *
          (((index - leftIndex) < 2 && (index - leftIndex) > -1)
              ? (leftIndex == index ? 1 - percent : percent)
              : 0);
}
