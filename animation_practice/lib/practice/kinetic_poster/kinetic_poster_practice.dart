import 'package:flutter/material.dart';
import 'dart:math' as math;

class KineticPosterPracticePage extends StatefulWidget {
  const KineticPosterPracticePage({Key? key}) : super(key: key);

  @override
  _KineticPosterPracticePageState createState() =>
      _KineticPosterPracticePageState();
}

class _KineticPosterPracticePageState extends State<KineticPosterPracticePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isOnLeft(double rotation) => math.cos(rotation) > 0;

  @override
  Widget build(BuildContext context) {
    final numberOfItems = 20;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(numberOfItems, (index) {
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final animationValue =
                    _animationController.value * 2 * math.pi / numberOfItems;

                double rotation = 2 * math.pi * index / numberOfItems +
                    math.pi / 2 +
                    animationValue;

                if (isOnLeft(rotation)) {
                  rotation = -rotation -
                      2 * math.pi / numberOfItems +
                      2 * animationValue;
                }

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(rotation),
                  child: FractionalTranslation(
                    translation: const Offset(-0.8, 0),
                    child: child,
                  ),
                );
              },
              child: const LinearTextPractice(),
            );
          }),
        ),
      ),
    );
  }
}

class LinearTextPractice extends StatelessWidget {
  const LinearTextPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 3,
        child: Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(.8),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [
              0.0,
              0.2,
              0.5,
            ],
          )),
          child: const Text(
            "LINEAR",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 110,
            ),
          ),
        ));
  }
}
