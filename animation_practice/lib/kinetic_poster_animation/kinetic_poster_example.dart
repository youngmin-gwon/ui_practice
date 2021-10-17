import 'package:flutter/material.dart';
import 'dart:math' as math;

class KineticPosterExamplePage extends StatefulWidget {
  const KineticPosterExamplePage({Key? key}) : super(key: key);

  @override
  _KineticPosterExamplePageState createState() =>
      _KineticPosterExamplePageState();
}

class _KineticPosterExamplePageState extends State<KineticPosterExamplePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final numberOfTexts = 20;

  bool isOnLeft(double rotation) => math.cos(rotation) > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            numberOfTexts,
            (index) {
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final animationRotationValue =
                      _animationController.value * 2 * math.pi / numberOfTexts;

                  double rotation = 2 * math.pi * index / numberOfTexts +
                      math.pi / 2 +
                      animationRotationValue;

                  if (isOnLeft(rotation)) {
                    rotation = -rotation -
                        math.pi * 2 / numberOfTexts +
                        2 * animationRotationValue;
                  }

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0012)
                      ..rotateY(rotation),
                    child: FractionalTranslation(
                      translation: const Offset(-0.8, 0),
                      child: child,
                    ),
                  );
                },
                child: const LinearText(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LinearText extends StatelessWidget {
  const LinearText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(.9),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [
              0.0,
              0.2,
              0.5,
            ],
          ),
        ),
        child: const Text(
          "LINEAR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 110,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
