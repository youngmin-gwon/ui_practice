// animated widget : use it to enhance ui code reusabilty

import 'dart:math' as math;

import 'package:flutter/material.dart';

class BasicAnimatedWidget extends StatefulWidget {
  const BasicAnimatedWidget({Key? key}) : super(key: key);

  @override
  _BasicAnimatedWidgetState createState() => _BasicAnimatedWidgetState();
}

class _BasicAnimatedWidgetState extends State<BasicAnimatedWidget>
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

    animation = Tween<double>(begin: 0, end: 1.0)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(animController)
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
    print("is it rebuilt? yes!");
    return Scaffold(
      // flutters default AnimatedBuilder
      // animation interval: 0 to 1 (not 0 to 2 * pi)
      body: SizeTransition(
        sizeFactor: animation,
        child: AnimatedIcon(),
      ),
      // body: RotatingTranstion(
      //   angle: animation,
      //   child: AnimatedIcon(),
      // ),
    );
  }
}

// AnimatedWidget extends StatfulWidget
// AnimatedWidget takes listenable in its constructor
// listenable is an animation (since animation extends or implements listenable)
// it does not need to add ..addListener(~ setState) !
class AnimatedIcon extends StatelessWidget {
  const AnimatedIcon({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    print("is child rebuilt? yes!");

    // return Transform.scale(
    //   scale: animation.value,
    //   child: Container(
    //     alignment: Alignment.center,
    //     padding: const EdgeInsets.all(16),
    //     child: Icon(Icons.person),
    //   ),
    // );
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Icon(Icons.person),
    );
  }
}

// *originally used
// class AnimatedIcon extends AnimatedWidget {
//   const AnimatedIcon({Key? key, required Animation<double> animation})
//       : super(key: key, listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final animation = super.listenable as Animation<double>;

//     print("is child rebuilt? yes!");

//     // return Transform.scale(
//     //   scale: animation.value,
//     //   child: Container(
//     //     alignment: Alignment.center,
//     //     padding: const EdgeInsets.all(16),
//     //     child: Icon(Icons.person),
//     //   ),
//     // );
//     return Transform.scale(
//       scale: animation.value,
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(16),
//         child: Icon(Icons.person),
//       ),
//     );
//   }
// }

// AnimatedBuilder : use to seperate even the motion into its widget
// - suitable for large animated subtree

class RotatingTranstion extends StatelessWidget {
  const RotatingTranstion({
    Key? key,
    required this.child,
    required this.angle,
  }) : super(key: key);

  final Widget child;
  final Animation<double> angle;

  // child will be pre-built by the builder for performance optimization
  @override
  Widget build(BuildContext context) {
    print("is second child rebuilt? yes!!");

    return AnimatedBuilder(
      animation: angle,
      builder: (context, child) {
        return Transform.rotate(
          angle: angle.value,
          child: child,
        );
      },
      child: child,
    );
  }
}
