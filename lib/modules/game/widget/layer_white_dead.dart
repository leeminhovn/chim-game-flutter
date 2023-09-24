import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayerWhiteDead extends StatefulWidget {
  @override
  State createState() => _LayerWhiteDead();
}

class _LayerWhiteDead extends State<LayerWhiteDead> {
  bool isShow = false;
  @override
  // void setState(VoidCallback fn) {

  // }
  @override
  Widget build(BuildContext context) {
    if (!isShow) {
      Future.delayed(Duration(milliseconds: 40), () {
        setState(() => isShow = true);
      });
    }

    return Positioned.fill(
      child: AnimatedContainer(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 2200),
        height: double.infinity,
        width: double.infinity,
        color: isShow ? null : Colors.white,
        child: SizedBox.shrink(),
      ),
    );
  }
}
