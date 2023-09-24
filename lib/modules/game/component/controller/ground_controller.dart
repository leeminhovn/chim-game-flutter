import 'package:flutter/cupertino.dart';
import 'dart:ui' as UI;

import '../../../../component/untils/game/position_2.dart';

class DrawGround extends CustomPainter {
  final UI.Image image;
  final double screenHeight;
  final double screenWidth;
  final position2D position;

  DrawGround(
      {required this.image,
      required this.screenHeight,
      required this.screenWidth,
      required this.position});

  @override
  void paint(UI.Canvas canvas, UI.Size size) {
    final paint = Paint();
    

    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst =
        Rect.fromLTWH(position.x, 0, screenWidth, 112 / 666.67 * screenHeight);

    final dst2 = Rect.fromLTWH(
        screenWidth + position.x, 0, screenWidth, 112 / 666.67 * screenHeight);

    canvas.drawImageRect(image, src, dst, paint);
    canvas.drawImageRect(image, src, dst2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class groundController {
  position2D _position;

  final double screenWidth;
  position2D get position => _position;

  set position(position2D value) {
    _position = value;
  }

  int framesElapsed = 0;

  int framesHold = 0;
  groundController(
      {required position2D position,
      required this.framesHold,
      required this.screenWidth})
      : _position = position;

  void updateFrames() {
    framesElapsed++;
    if (framesElapsed % framesHold == 0) {
      if (-1 <= (_position.x + screenWidth).floor() &&
          (_position.x + screenWidth).floor() <= 1) {
        _position.x = 0.0;
      }
      //0.45%
    }
    _position.x -= screenWidth * 0.0045;
  }
}
