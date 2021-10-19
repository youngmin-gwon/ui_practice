import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommandLinePage extends StatefulWidget {
  const CommandLinePage({Key? key}) : super(key: key);

  @override
  State<CommandLinePage> createState() => _CommandLinePageState();
}

class _CommandLinePageState extends State<CommandLinePage> {
  static const _flutterCommands = <String>[
    "flutter create my_new_app",
    "flutter run",
    "flutter build android",
    "flutter build ios",
    "flutter build web",
  ];

  int _currentCommandIndex = 0;

  void _nextCommand() {
    setState(() {
      _currentCommandIndex = _currentCommandIndex < _flutterCommands.length - 1
          ? _currentCommandIndex + 1
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 500,
            color: Colors.yellow,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Flutter CLI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Flutter includes a command-line interface that allows you to",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "- Create a new project\n- Run your app with Hot Reload/Restart\n- Build app binaries\n- and more!",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFFAAAAAA),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const SizedBox(width: 8),
                                Container(
                                  width: 12,
                                  height: 12,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 12,
                                  height: 12,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 12,
                                  height: 12,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                color: Color(0xFF444444),
                              ),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: TypeWriter(
                                  prefixText: ">",
                                  prefixTextStyle: const TextStyle(
                                    color: Color(0xFFCCCCCC),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  spacingAfterPrefix: 8,
                                  text: _flutterCommands[_currentCommandIndex],
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.yellow,
                                  ),
                                  cursorColor: Colors.white,
                                  onComplete: _nextCommand,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TypeWriter extends StatefulWidget {
  const TypeWriter({
    Key? key,
    required this.prefixText,
    required this.prefixTextStyle,
    required this.spacingAfterPrefix,
    required this.text,
    required this.textStyle,
    required this.cursorColor,
    this.onComplete,
  }) : super(key: key);

  final String prefixText;
  final TextStyle prefixTextStyle;
  final double spacingAfterPrefix;
  final String text;
  final TextStyle textStyle;
  final Color cursorColor;
  final VoidCallback? onComplete;

  @override
  _TypeWriterState createState() => _TypeWriterState();
}

class _TypeWriterState extends State<TypeWriter> {
  static const _minTypingPauseDelay = Duration(milliseconds: 20);
  static const _maxTypingPauseDelay = Duration(milliseconds: 200);

  late String _textToType;
  late int _nextToTypeIndex;
  late String _typedText;
  late BlinkingCursorController _cursorController;

  @override
  void initState() {
    super.initState();
    _textToType = widget.text;
    _nextToTypeIndex = 0;
    _typedText = "";

    _cursorController = BlinkingCursorController();

    _typeNewText();
  }

  @override
  void didUpdateWidget(covariant TypeWriter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      _textToType = widget.text;

      _typeNewText();
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  Future<void> _typeNewText() async {
    await Future.delayed(const Duration(milliseconds: 700));

    // widget 이 존재하지 않으면 setState시 에러를 발생시키므로 mounted 상태인지 확인
    if (!mounted) {
      return;
    }

    final firstDifferentCharacter =
        _findFirstDifferentChracter(_textToType, _typedText);

    await _eraseToIndex(firstDifferentCharacter);

    if (!mounted) {
      return;
    }

    // Type the text.
    await _typeForward();

    // Give the viewer a moment to appreciate the text.
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      widget.onComplete?.call();
    }
  }

  int _findFirstDifferentChracter(String label1, String label2) {
    int index = 0;
    while (index < label1.length &&
        index < label2.length &&
        label1[index] == label2[index]) {
      index += 1;
    }
    return index;
  }

  Future<void> _eraseToIndex(int index) async {
    for (var i = _typedText.length - 1; i >= index; --i) {
      await Future.delayed(const Duration(milliseconds: 40));

      if (!mounted) {
        return;
      }

      setState(() {
        _typedText = _typedText.substring(0, i);
        _nextToTypeIndex = i;

        _cursorController.reset();
      });
    }
  }

  Future<void> _typeForward() async {
    for (var i = _nextToTypeIndex; i < _textToType.length; ++i) {
      await Future.delayed(_generateTypingPauseDuration());

      if (!mounted) {
        return;
      }

      setState(() {
        _typedText = _textToType.substring(0, i + 1);
        _cursorController.reset();
      });
    }
  }

  Duration _generateTypingPauseDuration() {
    // lerpDuration(a, b, t)
    return _lerpDuration(
      _minTypingPauseDelay,
      _maxTypingPauseDelay,
      Random().nextDouble(),
    );
  }

  Duration _lerpDuration(Duration min, Duration max, double percent) {
    return Duration(
      milliseconds: lerpDouble(
        min.inMilliseconds,
        max.inMilliseconds,
        percent,
      )!
          .round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.prefixText,
          style: widget.prefixTextStyle,
        ),
        SizedBox(width: widget.spacingAfterPrefix),
        Text(
          _typedText,
          style: widget.textStyle,
        ),
        BlinkingCursor(
          fontSize: widget.textStyle.fontSize,
          color: Colors.white,
          controller: _cursorController,
        ),
      ],
    );
  }
}

class BlinkingCursor extends StatefulWidget {
  const BlinkingCursor({
    Key? key,
    required this.fontSize,
    required this.color,
    required this.controller,
  }) : super(key: key);

  final double? fontSize;
  final Color color;
  final BlinkingCursorController controller;

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor>
    with SingleTickerProviderStateMixin {
  static const pulsePeriod = Duration(milliseconds: 400);

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: pulsePeriod,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      })
      ..forward();

    widget.controller.addListener(_reset);
  }

  @override
  void didUpdateWidget(covariant BlinkingCursor oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_reset);

      widget.controller.addListener(_reset);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _reset() {
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          return Text(
            "|",
            style: TextStyle(
              color: widget.color.withOpacity(1.0 - _animationController.value),
              fontSize: widget.fontSize,
            ),
          );
        });
  }
}

class BlinkingCursorController with ChangeNotifier {
  void reset() {
    notifyListeners();
  }
}
