import 'dart:ui' as UI;
import 'package:chim_kha/component/untils/game/position_2.dart';
import 'package:chim_kha/config/router_name.dart';
import 'package:chim_kha/modules/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import '../../../component/resource/organisms/button_options.dart';
import '../component/controller/ground_controller.dart';

class MyDashboardGame extends StatefulWidget {
  final GameState gameState;
  const MyDashboardGame({super.key, required this.gameState});

  @override
  State<StatefulWidget> createState() => _MyDashboardGame();
}

class _MyDashboardGame extends State<MyDashboardGame>
    with SingleTickerProviderStateMixin {
  late AnimationController controllerGame;
  late groundController groundC;
  bool isStartZooOther = false;

  @override
  void initState() {
    controllerGame = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 16))
      ..repeat();

    groundC = groundController(
        position: position2D(0, 0),
        framesHold: 1,
        screenWidth: widget.gameState.configGame['safeWidth']);

    Future.delayed(
        const Duration(microseconds: 100),
        () => {
              if (context.mounted)
                {
                  setState(() {
                    isStartZooOther = true;
                  })
                }
            });

    super.initState();
  }

  @override
  void dispose() {
    controllerGame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextBuilder) {
    double screenWidth = widget.gameState.configGame['safeWidth'];
    double screenHeight = widget.gameState.configGame['safeHeight'];
    // final GameCubit valueProviderBloc = BlocProvider.of(context);
    handleOpenGame() {
      context.pushNamed(ApplicationRouteName.gamePlaySingle);
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: widget.gameState.loadList['background'].width.toDouble(),
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
          Positioned(
              child: CustomPaint(
            foregroundPainter: DrawLogoHalo(
                image: widget.gameState.loadList['logoHalo'],
                screenHeight: screenHeight,
                screenWidth: screenWidth),
          )),
          AnimatedBuilder(
              animation: controllerGame,
              builder: (BuildContext context, Widget? child) {
                groundC.updateFrames();
                return Positioned(
                  left: 0,
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(screenWidth, 112 / 666.67 * screenHeight),
                    foregroundPainter: DrawGround(
                        screenWidth: screenWidth,
                        image: widget.gameState.loadList['ground'],
                        screenHeight: screenHeight,
                        position: groundC.position),
                  ),
                );
              }),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            right: screenWidth * (isStartZooOther ? 0.6 : 1),
            curve: Curves.bounceOut,
            bottom: 132 / 666.67 * screenHeight,
            child: ButtonOptions(
              onTap: () {
                handleOpenGame();
              },
              text: 'Start',
            ),
          ),
          AnimatedPositioned(
            left: screenWidth * (isStartZooOther ? 0.6 : 1),
            curve: Curves.bounceOut,
            bottom: 132 / 666.67 * screenHeight,
            duration: const Duration(seconds: 1),
            child: ButtonOptions(
              onTap: () {
                print("Score");
              },
              text: 'Score',
            ),
          )
        ],
      ),
    );
  }
}

class DrawBackground extends CustomPainter {
  final UI.Image image;
  const DrawBackground({required this.image});

  @override
  void paint(UI.Canvas canvas, UI.Size size) {
    canvas.drawImage(image, const Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // print("run shouldRepaint function");

    return true;
  }
}

class DrawLogoHalo extends CustomPainter {
  final UI.Image image;
  final double screenWidth;
  final double screenHeight;
  DrawLogoHalo(
      {required this.screenWidth,
      required this.screenHeight,
      required this.image});
  @override
  void paint(UI.Canvas canvas, UI.Size size) {
    final paint = Paint();
    final double percentWh = image.height / image.width;
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(screenWidth * 0.5 - (screenWidth * 0.7 / 2),
        screenHeight * 0.3, screenWidth * 0.7, screenWidth * 0.7 * percentWh);
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
