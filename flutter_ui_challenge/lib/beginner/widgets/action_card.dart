import 'dart:math';

import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.color,
    required this.gradient,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final Color color;
  final Gradient gradient;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
        gradient: gradient,
      ),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(-20, 0),
            child: Opacity(
              opacity: .2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Transform.rotate(
                  angle: -pi / 5.5,
                  alignment: Alignment.centerRight,
                  child: ClipPath(
                    clipper: _BackgroundImageClipper(),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                        left: 60.0,
                      ),
                      child: Icon(
                        icon,
                        size: 90,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BackgroundImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
