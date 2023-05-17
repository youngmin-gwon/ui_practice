import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math.dart' show radians;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: SizedBox.expand(
          child: RadialMenu(),
        ),
      ),
    );
  }
}

class RadialMenu extends StatefulWidget {
  const RadialMenu({Key? key}) : super(key: key);

  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(
      controller: controller,
    );
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({
    Key? key,
    required this.controller,
  })  : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        rotation = Tween<double>(begin: 0, end: 360).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              0.7,
              curve: Curves.ease,
            ),
          ),
        ),
        translation = Tween<double>(begin: 0, end: 100).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.elasticInOut,
          ),
        ),
        super(key: key);

  final AnimationController controller;
  late Animation<double> scale;
  late Animation<double> rotation;
  late Animation<double> translation;

  void _open() {
    controller.forward();
  }

  void _close() {
    controller.reverse();
  }

  Widget _buildSubButtons(double angle,
      {required Color color, required IconData icon}) {
    final rad = radians(angle);

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          translation.value * cos(rad),
          translation.value * sin(rad),
        ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: color,
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("radial rebuilt");
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: radians(rotation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildSubButtons(
                0,
                color: Colors.red,
                icon: FontAwesomeIcons.thumbtack,
              ),
              _buildSubButtons(
                45,
                color: Colors.green,
                icon: FontAwesomeIcons.sprayCan,
              ),
              _buildSubButtons(
                90,
                color: Colors.orange,
                icon: FontAwesomeIcons.fire,
              ),
              _buildSubButtons(
                135,
                color: Colors.blue,
                icon: FontAwesomeIcons.kiwiBird,
              ),
              _buildSubButtons(
                180,
                color: Colors.black,
                icon: FontAwesomeIcons.cat,
              ),
              _buildSubButtons(
                225,
                color: Colors.indigo,
                icon: FontAwesomeIcons.paw,
              ),
              _buildSubButtons(
                270,
                color: Colors.pink,
                icon: FontAwesomeIcons.bong,
              ),
              _buildSubButtons(
                315,
                color: Colors.yellow,
                icon: FontAwesomeIcons.bolt,
              ),
              Transform.scale(
                scale: scale.value - 1.5,
                child: FloatingActionButton(
                  onPressed: _close,
                  child: const Icon(FontAwesomeIcons.timesCircle),
                  backgroundColor: Colors.red,
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  onPressed: _open,
                  child: const Icon(FontAwesomeIcons.solidCircle),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
