import 'package:flutter/widgets.dart';
import 'package:route_annotation/route_annotation.dart';

abstract class CustomRouteTemplete {
  @RoutePageBuilderFunction()
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      null;
  @RouteTransitionBuilderFunction()
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      null;
  @RouteTransitionDurationField()
  static Duration get transitionDuration => Duration(milliseconds: 400);

  @PageRouteBuilderFuntcion()
  static Route buildPageRoute(RouteSettings settings) => null;
}
