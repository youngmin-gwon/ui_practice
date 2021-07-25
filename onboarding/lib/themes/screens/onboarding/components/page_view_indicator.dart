import 'dart:ui';

import 'package:flutter/material.dart';

/// deprecated
class PageViewIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final Color color;

  const PageViewIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.color,
  }) : super(key: key);

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(
        length: 4,
        currentIndicator: widget.controller.page?.round() ?? -1,
        color: widget.color,
      ),
      child: Container(
        width: 60,
        height: 10,
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final Color color;
  final int length;
  final int currentIndicator;

  IndicatorPainter(
      {required this.length,
      required this.currentIndicator,
      this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < length; i++) {
      canvas.drawCircle(
        Offset(i * 5 * 3, 0),
        5,
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
    }
    canvas.drawCircle(
      Offset(currentIndicator * 5 * 3, 0),
      5,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (oldDelegate as IndicatorPainter).currentIndicator !=
        currentIndicator;
  }
}
