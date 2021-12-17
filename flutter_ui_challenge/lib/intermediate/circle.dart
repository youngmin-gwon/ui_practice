import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    Key? key,
    required this.color,
    required this.diameter,
    this.center,
  }) : super(key: key);

  final Color color;
  final double diameter;
  final Offset? center;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(diameter, diameter),
      painter: CirclePainter(
        color: color,
        center: center,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final Offset? center;

  const CirclePainter({
    required this.color,
    this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      center ?? Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
