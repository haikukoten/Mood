import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:moon/component/conuter_controller.dart';
import 'package:moon/resource.dart';
import 'package:moon/util.dart';

class DataScreen extends StatefulWidget {
  final int currentIndex;

  const DataScreen({Key key, this.currentIndex}) : super(key: key);
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  ConuterController _moodController = ConuterController();
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  double _moodValue = 0.82;

  Tween<double> _moodTween;
  Animation<double> _moodAnimation;

  void refresh() {
    _moodValue += 0.01;
    _moodTween = Tween(begin: 0.0, end: _moodValue);
    _moodAnimation = _moodTween.animate(_curvedAnimation);
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..addListener(() {
            setState(() {
              _moodController.progress = _moodAnimation.value;
            });
          });
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
    _moodTween = Tween(begin: 0.0, end: _moodValue);
    _moodAnimation = _moodTween.animate(_curvedAnimation);
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentIndex != 1) _animationController.forward(from: 0);
    return SizedBox.expand(
      child: Column(
        children: <Widget>[
          // Center(
          //   child: Text("data screen"),
          // ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: FlatButton(
              child: Text("刷新"),
              onPressed: refresh,
            ),
          ),
          Container(
            height: 140,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: <Widget>[
                  FlareActor(
                    R.counter,
                    controller: _moodController,
                    animation: "play",
                  ),
                  Center(
                    child: Text(
                      "${(_moodValue * 100).toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: colorRGB(182, 135, 221),
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
