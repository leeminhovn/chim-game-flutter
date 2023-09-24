import 'dart:async';
import 'dart:math';

import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as UI;
import '../../../../component/untils/game/position_2.dart';

class BirdController {
  final GameState gameState;
  late List<UI.Image> image;
  late Map<String, dynamic> configGame;
  int currnetframeIdx = 1;
  late BirdObject birdInfo;
  late double groundYposiiton;
  BirdController({
    required this.gameState,
  }) {

    image = gameState.loadList['birdYellow'];
    configGame = gameState.configGame;
    groundYposiiton =
        configGame['safeHeight'] - (112 / 666.67 * configGame['safeHeight']);
    birdInfo = BirdObject(
      frames: image,
      frameSize: Size(image[0].width.toDouble(), image[0].height.toDouble()),
      screenWidth: configGame['safeWidth'],
      screenHeight: configGame['safeHeight'],
    );
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (birdInfo.status != "die") {
        birdInfo.framesElapsed += 1;

        if (birdInfo.isLastFrame) {
          if (currnetframeIdx == 0) {
            birdInfo.isLastFrame = false;
          }
        } else {
          if (currnetframeIdx == 2) {
            birdInfo.isLastFrame = true;
          }
        }
        if (birdInfo.framesElapsed % birdInfo.framesHold == 0) {
          birdInfo.isLastFrame ? currnetframeIdx-- : currnetframeIdx++;
          birdInfo.framesElapsed++;
        }
      }
    });
    Timer.periodic(const Duration(milliseconds: 8), (timer) {
      if (birdInfo.status != 'updating' && birdInfo.status != 'fly') {
        birdInfo.time += 0.001;
      }

      if (birdInfo.oldPositionY < birdInfo.position.y) {
        birdInfo.currentDegree < pi / 2
            ? birdInfo.currentDegree += 0.1
            : birdInfo.currentDegree = pi / 2;
      }
    });
  }

  void birdUp() {
    birdInfo.status = "updating";
    birdInfo.currentDegree = -pi / 5;
    birdInfo.oldPositionY = birdInfo.position.y;
    birdInfo.time = 0;
    birdInfo.status = "flying";
  }

  void update() {
    double time = birdInfo.time * birdInfo.speedFly;

    if (birdInfo.status == "flying") {
      birdInfo.position.y = birdInfo.oldPositionY -
          (birdInfo.velocity * time -
              1 / 2 * birdInfo.gravityAcceleration * pow(time, 2));
    }
  }

  void checkGround(Function handleDead, bool dead) {
    if (birdInfo.position.y + birdInfo.heightDrawBird >= groundYposiiton) {
      birdInfo.dy = 0;

      birdInfo.position.y = groundYposiiton - (birdInfo.heightDrawBird);
      if (!dead) {
        handleDead();
      }
    }
  }

  Widget drawBird(bool dead, Function handleDead) {
    update();

    Widget renderBird = CustomPaint(
      isComplex: true,
      willChange: true,
      foregroundPainter:
          DrawBirdPaint(currnetframeIdx: currnetframeIdx, birdInfo: birdInfo),
    );

    checkGround(handleDead, dead);

    return renderBird;
  }
}

class DrawBirdPaint extends CustomPainter {
  late int currnetframeIdx;
  final BirdObject birdInfo;
  DrawBirdPaint({required this.birdInfo, required this.currnetframeIdx});
  @override
  void paint(Canvas canvas, size) {
    final Paint paint = Paint()..strokeWidth = 4;

    final src = Rect.fromLTWH(0, 0, birdInfo.frameSize.width.toDouble(),
        birdInfo.frameSize.height.toDouble());
    final dst = Rect.fromLTWH(birdInfo.position.x, birdInfo.position.y,
        birdInfo.widthDrawBird, birdInfo.heightDrawBird);

    canvas.save();
    canvas.translate(dst.center.dx, dst.center.dy);
    canvas.rotate(birdInfo.currentDegree);
    canvas.translate(-dst.center.dx, -dst.center.dy);
    canvas.drawImageRect(birdInfo.frames[currnetframeIdx], src, dst, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BirdObject {
  double currentDegree = 0.0;
  final double screenWidth;
  final double screenHeight;
  String status = "fly";
  late position2D position;
  late double widthDrawBird;
  final double speedFly = 100;
  late double velocity;
  late double oldPositionY;
  final Size frameSize;
  bool isLastFrame = false;
  late double heightDrawBird;
  final int framesHold = 1;
  double framesElapsed = 0;
  late double flyHeight;
  double time = 0.0;
  late double gravityAcceleration;
  final double friction = 0.9;
  double dy = 0;
  // y += dy
  final List<UI.Image> frames;
  BirdObject({
    required this.screenWidth,
    required this.frameSize,
    required this.frames,
    required this.screenHeight,
  }) {
    widthDrawBird = screenWidth * 0.11;
    flyHeight = screenHeight * 0.11;
    heightDrawBird = widthDrawBird * (frameSize.height / frameSize.width);
    velocity = sqrt(flyHeight * 2 * 9.8);
    gravityAcceleration = 9.8;
    position = position2D(screenWidth * 0.3, screenHeight * 0.5);
    oldPositionY = screenHeight * 0.5;
  }
}
