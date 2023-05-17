import 'package:animation_practice/balloon_animation/balloon_initial_page.dart';
import 'package:flutter/material.dart';

const mainColor = Color(0xFF5113AA);
const secondaryColor = Color(0xFFBC53FA);
const backgroundColor = Color(0xFFFCE7FE);

class BalloonPage extends StatelessWidget {
  const BalloonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          BalloonInitialPage(),
        ],
      ),
    );
  }
}
