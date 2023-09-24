import 'dart:async';

import 'package:chim_kha/component/untils/game/position_2.dart';

import 'package:chim_kha/modules/game/component/controller/pip_controller.dart';
import 'package:chim_kha/modules/game/component/controller/sound_effect_controller.dart';
import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:chim_kha/modules/game/widget/layer_white_dead.dart';
import 'package:chim_kha/modules/game/widget/popup_dead.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';

import '../component/controller/bird_controller.dart';
import '../component/controller/ground_controller.dart';

import 'my_dashboard_game.dart';

class PlayGame extends StatefulWidget {
  final GameState gameState;

  const PlayGame({super.key, required this.gameState});

  @override
  State<PlayGame> createState() => _PlayGame();
}

class _PlayGame extends State<PlayGame> with SingleTickerProviderStateMixin {
  late groundController groundC;
  late PipController pipController;
  final StreamController<int> pointController =
      StreamController<int>.broadcast();
  bool _visiblePlayGuide = false;
  bool dead = false;
  bool showPlayMessage = true;
  bool isPlaying = false;
  int point = 0;

  final SoundEffectController soundEffect = SoundEffectController();
  late AnimationController controllerGame;
  late StreamController<String> popupController;
  late BirdController birdController =
      BirdController(gameState: widget.gameState);
  @override
  void initState() {
    super.initState();
    popupController = StreamController<String>();
    pipController =
        PipController(gameState: widget.gameState, handleDead: handleDead);
    controllerGame = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 16))
      ..repeat();

    groundC = groundController(
        position: position2D(0, 0),
        framesHold: 1,
        screenWidth: widget.gameState.configGame['safeWidth']);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (context.mounted) {
        setState(() {
          _visiblePlayGuide = true;
        });
      }
    });
  }

  void handleDead() {
    soundEffect.hitPlayAudio.handlePlayAudio();
    dead = true;
    popupController.add('overlay_layer_white');
    Future.delayed(const Duration(milliseconds: 500), () {
      soundEffect.diePlayAudio.handlePlayAudio();

      popupController.add('popup_dead');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerGame.dispose();
    popupController.close();
    soundEffect.hitPlayAudio.dispose();
    soundEffect.diePlayAudio.dispose();
    soundEffect.wingPlayAudio.dispose();
    soundEffect.pointPlayAudio.dispose();
    pointController.close();
    super.dispose();
  }

  handleTap() {
    if (dead == false) {
      soundEffect.wingPlayAudio.handlePlayAudio();
      birdController.birdUp();
    }
  }

  @override
  Widget build(BuildContext contextBuilder) {
    double screenWidth = widget.gameState.configGame['safeWidth'];
    double screenHeight = widget.gameState.configGame['safeHeight'];
    return Scaffold(
      body: GestureDetector(
        onTapDown: (_) {
          handleTap();
        },
        child: SafeArea(
          child: Stack(children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width:
                      widget.gameState.loadList['background'].width.toDouble(),
                  height:
                      widget.gameState.loadList['background'].height.toDouble(),
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: DrawBackground(
                        image: widget.gameState.loadList['background'],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (showPlayMessage == false)
              AnimatedBuilder(
                animation: controllerGame,
                builder: (_, __) {
                  return Wrap(
                    children: [
                      ...pipController.drawPip(birdController.birdInfo, dead,
                          pointController),
                    ],
                  );
                },
              ),
            AnimatedBuilder(
                animation: controllerGame,
                builder: (contextBuilder, child) {
                  return birdController.drawBird(dead, handleDead);
                }),
            Positioned(
              left: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: controllerGame,
                builder: (context, child) {
                  if (dead == false) groundC.updateFrames();

                  return CustomPaint(
                    size: Size(screenWidth, 112 / 666.67 * screenHeight),
                    foregroundPainter: DrawGround(
                        screenWidth: screenWidth,
                        image: widget.gameState.loadList['ground'],
                        screenHeight: screenHeight,
                        position: groundC.position),
                  );
                },
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: StreamBuilder<int>(
                    initialData: 0,
                    stream: pointController.stream,
                    builder: (context, snapshot) {
                      point += snapshot.data ?? 0;
                      if (point != 0) {
                          soundEffect.pointPlayAudio.handlePlayAudio();
                      }
                      return Text(
                        point.toString(),
                        style: const TextStyle(
                          fontFamily: 'Sabo',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      );
                    }),
              ),
            ),
            if (showPlayMessage)
              Positioned.fill(
                  child: GestureDetector(
                onTap: () {
                  handleTap();
                  setState(() {
                    isPlaying = true;
                    _visiblePlayGuide = false;
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _visiblePlayGuide ? 1.0 : 0.0,
                    onEnd: () {
                      setState(() {
                        showPlayMessage = _visiblePlayGuide;
                      });
                    },
                    child: CustomPaint(
                      painter: DrawMessageHowToPlay(
                          image:
                              widget.gameState.loadList['textMessageGuidePlay'],
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    ),
                  ),
                ),
              )),
            StreamBuilder(
                stream: popupController.stream,
                builder: ((context, snapshot) {
                  if (snapshot.data == "popup_dead") {
                    return Center(
                      child: PopupDead(point: point),
                    );
                  } else if (snapshot.data == "overlay_layer_white") {
                    return LayerWhiteDead();
                  }
                  return const SizedBox.shrink();
                }))
          ]),
        ),
      ),
    );
  }
}

class DrawMessageHowToPlay extends CustomPainter {
  final UI.Image image;
  final double screenWidth;
  final double screenHeight;
  DrawMessageHowToPlay(
      {required this.screenWidth,
      required this.screenHeight,
      required this.image});
  @override
  void paint(UI.Canvas canvas, UI.Size size) {
    final paint = Paint();
    final double percentWh = image.height / image.width;
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(screenWidth * 0.5 - (screenWidth * 0.6 / 2),
        screenHeight * 0.2, screenWidth * 0.6, screenWidth * 0.6 * percentWh);
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
