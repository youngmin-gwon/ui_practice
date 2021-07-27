import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );

    // final curvedAnimation = CurvedAnimation(
    //   parent: animController,
    //   curve: Curves.bounceIn,
    //   reverseCurve: Curves.easeOut,
    // );

    // animation =
    //     Tween<double>(begin: 1.0, end: 2 * math.pi).animate(curvedAnimation)
    //       ..addListener(() {
    //         setState(() {});
    //       })
    //       ..addStatusListener((status) {
    //         if (status == AnimationStatus.completed) {
    //           animController.reverse();
    //         } else if (status == AnimationStatus.dismissed) {
    //           animController.forward();
    //         }
    //       });

    animation = Tween<double>(begin: 1.0, end: 2 * math.pi)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(animController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animController.forward();
            }
          });

    animController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
