import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

// new
enum AnimProps {
  opacity,
  width,
  height,
  padding,
  borderRadius,
  color,
}

class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController controller;

  // late Animation<double> opacity;
  // late Animation<double> width;
  // late Animation<double> height;
  // late Animation<EdgeInsets> padding;
  // late Animation<BorderRadius> borderRadius;
  // late Animation<Color?> color;

  // ** new
  late Animation<TimelineValue<AnimProps>> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // ** simple_animations provides TimelineTween
    // => single tween which encompass all of the tweens

    // opacity = Tween<double>(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.0,
    //       0.200,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );
    // width = Tween<double>(
    //   begin: 50.0,
    //   end: 150.0,
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.200,
    //       0.250,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );
    // height = Tween<double>(begin: 50.0, end: 150.0).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.250,
    //       0.375,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );
    // padding = EdgeInsetsTween(
    //   begin: const EdgeInsets.only(bottom: 16.0),
    //   end: const EdgeInsets.only(bottom: 75.0),
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.250,
    //       0.375,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );
    // borderRadius = BorderRadiusTween(
    //   begin: BorderRadius.circular(4.0),
    //   end: BorderRadius.circular(75.0),
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.375,
    //       0.500,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );
    // color = ColorTween(
    //   begin: Colors.indigo[100],
    //   end: Colors.orange[400],
    // ).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(
    //       0.500,
    //       0.750,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );

    // add scene : add new animation tween
    // => after add scene, add subsequent scene for relative timeline animation
    animation = TimelineTween<AnimProps>()
        // opacity
        .addScene(
            begin: 0.milliseconds, end: 1000.milliseconds, curve: Curves.ease)
        .animate(AnimProps.opacity, tween: Tween<double>(begin: 0, end: 1))
        // width
        .addSubsequentScene(
            duration: 125.milliseconds,
            delay: 25.milliseconds,
            curve: Curves.ease)
        .animate(AnimProps.width, tween: Tween<double>(begin: 50, end: 150))
        // height & padding >> check how to add two animation in same sequence
        .addSubsequentScene(duration: 125.milliseconds, curve: Curves.ease)
        .animate(AnimProps.height,
            tween: Tween<double>(begin: 50.0, end: 150.0))
        .animate(AnimProps.padding,
            tween: EdgeInsetsTween(
                begin: const EdgeInsets.only(bottom: 16.0),
                end: const EdgeInsets.only(bottom: 75.0)))
        // borderRadius
        .addSubsequentScene(duration: 125.milliseconds, curve: Curves.ease)
        .animate(AnimProps.borderRadius,
            tween: BorderRadiusTween(
              begin: BorderRadius.circular(16.0),
              end: BorderRadius.circular(75.0),
            ))
        // color
        .addSubsequentScene(duration: 250.milliseconds, curve: Curves.ease)
        .animate(AnimProps.color,
            tween:
                ColorTween(begin: Colors.indigo[100], end: Colors.orange[400]))
        .parent
        .animatedBy(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          } else if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          }
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: _buildAnimation,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: animation.value.get(AnimProps.padding),
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: animation.value.get(AnimProps.opacity),
        child: Container(
          width: animation.value.get(AnimProps.width),
          height: animation.value.get(AnimProps.height),
          decoration: BoxDecoration(
            color: animation.value.get(AnimProps.color),
            border: Border.all(
              color: Colors.indigo[300]!,
              width: 3.0,
            ),
            borderRadius: animation.value.get(AnimProps.borderRadius),
          ),
        ),
      ),
    );
  }
}
