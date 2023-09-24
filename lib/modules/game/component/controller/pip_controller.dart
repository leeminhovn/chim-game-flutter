import 'dart:async';
import 'dart:math';
import 'dart:ui' as UI;

import 'package:chim_kha/modules/game/component/common/clashcollision.dart';
import 'package:chim_kha/modules/game/component/controller/bird_controller.dart';
import 'package:chim_kha/modules/game/component/controller/sound_effect_controller.dart';
import 'package:flutter/material.dart';

import '../../cubit/game_cubit.dart';

class PipController {
  final GameState gameState;
  late List<UI.Image> listImage;
  late double screenWidth;
  late double screenHeight;
  late double groundYposiiton;
  late double pipDrawWidth;
  Function handleDead;
  final List<PipObject> pips = [];

  PipController({required this.gameState, required this.handleDead}) {
    screenHeight = gameState.configGame['safeHeight'];
    screenWidth = gameState.configGame['safeWidth'];
    listImage = [
      gameState.loadList['pipeGreenTop'],
      gameState.loadList['pipeGreenBody']
    ];
    pipDrawWidth = screenWidth * (52 / 375);

    initPip();
    groundYposiiton = screenHeight - (112 / 666.67 * screenHeight);
  }
  void initPip() {
    double newPosition = screenWidth;
    for (int i = 0; i < 3; i++) {
      double space = randomDistanceBetweenPip(screenWidth);
      newPosition += space;
      final Map<String, double> heightPips = randomDistancePip(screenHeight);
      pips.add(PipObject(
          heightPip1: heightPips["pipTop"]!,
          heightPip2: heightPips["pipBottom"]!,
          positionX: newPosition));
    }
  }

  void check(
    BirdObject birdInfo,
    StreamController pointController,
    bool dead,
  ) {
    final double widthImageTop = listImage[0].width.toDouble() * 1;
    final double heightImageTop = listImage[0].height.toDouble() * 1;
    final double pipDrawHeightTop =
        pipDrawWidth * (heightImageTop / widthImageTop);

    final double widthDrawBird = birdInfo.widthDrawBird * 0.86;
    final double heightDrawBird = birdInfo.heightDrawBird * 0.84;

    Rect birdRect = Rect.fromLTWH(birdInfo.position.x, birdInfo.position.y,
        widthDrawBird, heightDrawBird);
    for (int idx = 0; idx <= 1; idx++) {
      // pip
      PipObject pip = pips[idx];

      double positionX = pip._positionX;
      double heightPip1 = pip.heightPip1;
      double heightPip2 = pip.heightPip2;

      bool bottomPipCheck = areRectanglesColliding(
          birdRect,
          birdInfo.currentDegree,
          Rect.fromLTWH(positionX, groundYposiiton - heightPip1, pipDrawWidth,
              pipDrawHeightTop),
          0);
      bool bottomPipCheckBody = areRectanglesColliding(
          birdRect,
          birdInfo.currentDegree,
          Rect.fromLTWH(
              positionX,
              groundYposiiton - (heightPip1 - pipDrawHeightTop),
              pipDrawWidth,
              heightPip1 - pipDrawHeightTop),
          0);
      bool topPipCheck = areRectanglesColliding(
          birdRect,
          birdInfo.currentDegree,
          Rect.fromLTWH(positionX, heightPip2 - pipDrawHeightTop, pipDrawWidth,
              pipDrawHeightTop),
          0);
      bool topPipCheckBody = areRectanglesColliding(
          birdRect,
          birdInfo.currentDegree,
          Rect.fromLTWH(
              positionX, 0, pipDrawWidth, heightPip2 - pipDrawHeightTop),
          0);

      if (topPipCheck ||
          bottomPipCheck ||
          topPipCheckBody ||
          bottomPipCheckBody) {
        if (dead == false) {
          handleDead();
        }
      } else if (birdInfo.position.x - positionX - pipDrawWidth > 0 &&
          pips[idx].overcome == false) {
        pips[idx].overcome = true;
        pointController.add(1);
      }

      if (idx == 0 && (pip._positionX + pipDrawWidth <= 0)) {
        pips.removeAt(0);
        pips.add(resetPip(pip));
      }
    }
  }

  void update(BirdObject birdInfo, StreamController pointController) {
    for (int idx = 0; idx < pips.length; idx++) {
      // pip
      PipObject pip = pips[idx];

      pip._positionX -= screenWidth * 0.0045;
    }
  }

  PipObject resetPip(PipObject pip) {
    pip.overcome = false;
    pip._positionX =
        pips.last._positionX + randomDistanceBetweenPip(screenWidth);
    Map<String, double> pipHeight = randomDistancePip(screenHeight);
    pip.heightPip1 = pipHeight['pipTop']!;
    pip.heightPip2 = pipHeight['pipBottom']!;

    return pip;
  }

  Iterable<CustomPaint> drawPip(
      BirdObject birdInfo, bool dead, StreamController pointController) {
    if (dead == false) update(birdInfo, pointController);

    final Iterable<CustomPaint> pipsRender = pips.map((pip) => CustomPaint(
          // isComplex: true,
          willChange: true,
          foregroundPainter: DrawPipPaint(
              groundYposiiton: groundYposiiton,
              positionX: pip._positionX,
              heightPip1: pip.heightPip1,
              heightPip2: pip.heightPip2,
              listImage: listImage,
              pipDrawWidth: pipDrawWidth),
        ));
    if (dead == false) check(birdInfo, pointController, dead);
    return pipsRender;
  }
}

class DrawPipPaint extends CustomPainter {
  final double pipDrawWidth;
  final List<UI.Image> listImage;
  final double groundYposiiton;
  final double heightPip1;
  final double heightPip2;
  final double positionX;
  DrawPipPaint({
    required this.heightPip1,
    required this.heightPip2,
    required this.positionX,
    required this.pipDrawWidth,
    required this.listImage,
    required this.groundYposiiton,
  });

  @override
  void paint(UI.Canvas canvas, UI.Size size) {
    final Paint paint = Paint();

    final double widthImageTop = listImage[0].width.toDouble();
    final double heightImageTop = listImage[0].height.toDouble();
    final double pipDrawHeightTop =
        pipDrawWidth * (heightImageTop / widthImageTop);
    final src = Rect.fromLTWH(0, 0, widthImageTop, heightImageTop);

    final dst = Rect.fromLTWH(positionX, groundYposiiton - heightPip1,
        pipDrawWidth, pipDrawHeightTop);

    final double widthImageBody = listImage[1].width.toDouble();
    final double heightImageBody = listImage[1].height.toDouble();

    final srcBody = Rect.fromLTWH(0, 0, widthImageBody, heightImageBody);

    final dstBody = Rect.fromLTWH(
        positionX,
        groundYposiiton - (heightPip1 - pipDrawHeightTop),
        pipDrawWidth,
        heightPip1 - pipDrawHeightTop);

    canvas.drawImageRect(listImage[0], src, dst, paint);
    canvas.drawImageRect(listImage[1], srcBody, dstBody, paint);

    final dst2Top = Rect.fromLTWH(positionX, heightPip2 - pipDrawHeightTop,
        pipDrawWidth, pipDrawHeightTop);

    final dst2Body = Rect.fromLTWH(
        positionX, 0, pipDrawWidth, heightPip2 - pipDrawHeightTop);

    canvas.save();
    canvas.translate(dst2Top.center.dx, dst2Top.center.dy);
    canvas.rotate(pi);
    canvas.translate(-dst2Top.center.dx, -dst2Top.center.dy);
    canvas.drawImageRect(listImage[0], src, dst2Top, paint);
    canvas.restore();
    canvas.drawImageRect(listImage[1], srcBody, dst2Body, paint);
  }

  @override
  bool shouldRepaint(_) {
    return true;
  }
}

class PipObject {
  double heightPip1;
  double heightPip2;
  late double _positionX;
  bool overcome = false;
  PipObject(
      {required this.heightPip1,
      required this.heightPip2,
      double positionX = 0.0}) {
    _positionX = positionX;
  }
}

double randomDistanceBetweenPip(double screenWidth) {
  return Random().nextInt(10) <= 7 ? screenWidth * 0.5 : screenWidth * 0.6;
}

Map<String, double> randomDistancePip(double screenHeight) {
  double pipTop = 0.0;
  double pipBottom = 0.0;
  double heightGroundHalf = 112 / 666.67 * screenHeight / 2;
  double heightOnGround = screenHeight - heightGroundHalf * 2;
  pipTop = (0.3 + Random().nextDouble() * 0.74) * (heightOnGround / 2);
  pipBottom = heightOnGround -
      (pipTop + (1 + Random().nextDouble() * 0.2) * heightOnGround * 0.238);
  return {"pipTop": pipTop, "pipBottom": pipBottom};
}
