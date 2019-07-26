import 'package:flutter/material.dart';

class MoodCircle extends StatelessWidget {
  final Color color;
  final double edge;
  final double size;
  final EdgeInsetsGeometry padding;

  final GestureTapCallback onPress;

  const MoodCircle(
      {Key key,
      @required this.color,
      this.padding = const EdgeInsets.all(4.0),
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ),
      ),
    );
  }
}
