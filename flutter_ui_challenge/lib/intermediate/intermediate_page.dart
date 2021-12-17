import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge/intermediate/animated_text.dart';
import 'package:flutter_ui_challenge/intermediate/circle.dart';

class IntermediatePage extends StatelessWidget {
  const IntermediatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedText(
          text: "한글은 문제없이 잘 써지나요?",
          delayInMilliseconds: 100,
          durationInMilliseconds: 2000,
        ),
      ),
    );
  }
}
