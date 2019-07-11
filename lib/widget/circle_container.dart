import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final double radius;
  final Offset position;
  final Color color;
  final Color backgroundColor;
  final Widget child;

  /// * [radius] 圆的半径
  /// * [color] 圆的颜色
  /// * [backgroundColor] 背景颜色,
  /// * [position] 圆形位置,为 `null` 时,默认取 [Widget] 中心坐标,
  const CircleContainer(
      {Key key,
      this.radius,
      this.position,
      this.color,
      this.child,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => CustomPaint(
          size: constraints.biggest,
          painter: CirclePainter(
            radius,
            position ?? Offset(constraints.biggest.width / 2, constraints.biggest.height / 2),
            color,
          ),
          child: child,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  double radius;
  Offset position;
  Color color;
  CirclePainter(this.radius, this.position, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.position != position ||
      oldDelegate.color != color;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
