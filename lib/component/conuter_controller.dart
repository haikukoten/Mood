import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

class ConuterController with FlareController {
  ActorAnimation _conuter;
  double progress = 0.0;
  @override
  void initialize(FlutterActorArtboard artboard) {
    _conuter = artboard.getAnimation("play");
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _conuter.apply(_conuter.duration * progress, artboard, 1.0);
    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
