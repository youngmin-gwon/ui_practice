import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key? key,
    required this.text,
    required this.delayInMilliseconds,
    required this.durationInMilliseconds,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final int delayInMilliseconds;
  final int durationInMilliseconds;
  final TextStyle? textStyle;

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  String currentText = "";

  late AnimationController animationController;

  late List<int> textRunes;
  int curIndex = 0;

  @override
  void initState() {
    super.initState();
    textRunes = widget.text.runes.toList();

    animationController = AnimationController(
      vsync: this,
      value: 0.0,
      upperBound: textRunes.length.toDouble(),
      duration: Duration(
        milliseconds: widget.durationInMilliseconds,
      ),
    );

    animationController.addListener(() {
      if (animationController.value.toInt() == 0) {
        setState(() {
          currentText = String.fromCharCode(textRunes[0]);
        });
      } else if (animationController.value.toInt() > curIndex &&
          animationController.value.toInt() < textRunes.length) {
        setState(() {
          curIndex = animationController.value.toInt();
          currentText += String.fromCharCode(textRunes[curIndex]);
        });
      }
    });

    forwardAnimationWithInterval();
  }

  Future<void> forwardAnimationWithInterval() async {
    await Future.delayed(Duration(milliseconds: widget.delayInMilliseconds));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentText,
      textAlign: TextAlign.left,
      style: widget.textStyle ??
          const TextStyle(fontWeight: FontWeight.w600, fontSize: 28.0),
    );
  }
}
