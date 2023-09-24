import 'package:flutter/material.dart';

@override
AlertDialog customDialog(BuildContext context, List<Widget> children) {
  final double screenWidth = MediaQuery.of(context).size.width;
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    // title: Text('Học nhảy tiktok  cùng công chúa mây'),
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: screenWidth * 0.98,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          constraints: const BoxConstraints(minHeight: 310, maxWidth: 500),
        
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
     
      ],
    ),
  );
}
