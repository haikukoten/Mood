import 'package:flutter/material.dart';

class ThemeCircle extends StatelessWidget {
  final List<Color> colors;
  final double edge;
  final double size;
  final EdgeInsetsGeometry padding;

  final GestureTapCallback onPress;

  const ThemeCircle(
      {Key key,
      @required this.colors,
      this.padding = const EdgeInsets.all(24.0),
      this.edge = 4,
      this.size = 56,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: padding,
        child: Container(
          padding: EdgeInsets.all(edge),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          height: size,
          width: size,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: colors,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
