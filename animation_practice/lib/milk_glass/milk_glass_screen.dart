import 'dart:math';

import 'package:flutter/material.dart';

class MilkGlassScreen extends StatefulWidget {
  const MilkGlassScreen({super.key});

  @override
  _MilkGlassScreenState createState() => _MilkGlassScreenState();
}

class _MilkGlassScreenState extends State<MilkGlassScreen> {
  double _skew = 0.2;
  double _ratio = 0.7;
  double _fullness = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              height: 200,
              child: CustomPaint(
                painter: MilkGlassPainter(
                  skew: .01 + _skew * .4,
                  ratio: _ratio,
                  fullness: _fullness,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 24, top: 12),
              child: const Text(
                "Skewness",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Slider(
              value: _skew,
              onChanged: (double newValue) {
                setState(() {
                  _skew = newValue;
                });
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 24, top: 12),
              child: const Text(
                "Ratio",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Slider(
              value: _ratio,
              onChanged: (double newValue) {
                setState(() {
                  _ratio = newValue;
                });
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 24, top: 12),
              child: const Text(
                "Fullness",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Slider(
              value: _fullness,
              onChanged: (double newValue) {
                setState(() {
                  _fullness = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MilkGlassPainter extends CustomPainter {
  final double skew;
  final double ratio;
  final double fullness;
  const MilkGlassPainter({
    required this.skew,
    required this.ratio,
    required this.fullness,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final glass = Paint()
      ..color = Colors.white.withAlpha(150)
      ..style = PaintingStyle.fill;
    final milkTopColor = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final milkColor = Paint()
      ..color = const Color.fromARGB(255, 235, 235, 235)
      ..style = PaintingStyle.fill;
    final black = Paint()
      ..color = Colors.black.withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final top = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.width * skew,
    );
    final bottom = Rect.fromCenter(
        center: Offset(
          size.width * .5,
          size.height - size.width * .5 * skew * ratio,
        ),
        width: size.width * ratio,
        height: size.width * skew * ratio,);

    final liquidTop = Rect.lerp(top, bottom, fullness)!;

    final cupPath = Path()
      ..moveTo(top.left, top.top + top.height * .5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height / 2)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * .5);

    final liquidPath = Path()
      ..moveTo(liquidTop.left, liquidTop.top + liquidTop.height * .5)
      ..arcTo(liquidTop, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height / 2)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(liquidTop.left, liquidTop.top + liquidTop.height * .5);

    canvas.drawPath(cupPath, glass);
    canvas.drawPath(liquidPath, milkColor);
    canvas.drawOval(liquidTop, milkTopColor);
    canvas.drawPath(cupPath, black);
    canvas.drawOval(top, black);
  }

  @override
  bool shouldRepaint(covariant MilkGlassPainter oldDelegate) {
    return oldDelegate.fullness != fullness ||
        oldDelegate.ratio != ratio ||
        oldDelegate.skew != skew;
  }
}
