import 'package:chim_kha/component/general/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:chim_kha/component/untils/sound_effect.dart';
import '../../general/constant/app_colors.dart';

class ButtonOptions extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  const ButtonOptions({super.key, required this.text, required this.onTap});

  @override
  State<ButtonOptions> createState() => _ButtonOptionsState();
}

class _ButtonOptionsState extends State<ButtonOptions> {
  bool isActive = false;
  late AudioPlay audioPlayAction;
  @override
  void initState() {
    audioPlayAction = AudioPlay(assetsFile: AppConstant.audiosLoad["swoosh"]);
        
    super.initState();
  }

  @override
  dispose() {
    audioPlayAction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Transform.translate(
      offset: Offset(0, !isActive ? 0 : screenWidth * 0.0048),
      child: Container(
        width: screenWidth * 0.23,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: screenWidth * 0.0048,
            ),
            top: BorderSide(
              width: screenWidth * 0.0048,
            ),
            bottom: BorderSide(
              width: !isActive ? screenWidth * 0.01 : screenWidth * 0.0048,
            ),
            right: BorderSide(
              width: screenWidth * 0.0048,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            audioPlayAction.handlePlayAudio();

            widget.onTap!();
            if (isActive) return;
            setState(() {
              isActive = true;
            });
            await Future.delayed(
                const Duration(milliseconds: 100),
                () => setState(() {
                      isActive = false;
                    }));
          },
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: Container(
              decoration: BoxDecoration(color: AppColors.b95007Color),
              margin: EdgeInsets.all(screenWidth * 0.005),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        fontFamily: 'Sabo',
                        fontSize: 20,
                        color: Colors.white,
                        height: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
