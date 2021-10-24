import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import 'package:animation_practice/assets/assets.gen.dart';

class NewYearCelebrationScreen extends StatelessWidget {
  const NewYearCelebrationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimeLapse(
        overrideStartDateTime: DateTime.parse("2021-12-31 20:59:51"),
        doTick: true,
        dateTimeBuilder: (DateTime currentTime) {
          return NewYearsCountDownPage(
            currentTime: currentTime,
          );
        },
      ),
    );
  }
}

class TimeLapse extends StatefulWidget {
  const TimeLapse({
    Key? key,
    this.overrideStartDateTime,
    this.doTick = true,
    required this.dateTimeBuilder,
  }) : super(key: key);

  final DateTime? overrideStartDateTime;
  final bool doTick;
  final Widget Function(DateTime) dateTimeBuilder;

  @override
  _TimeLapseState createState() => _TimeLapseState();
}

class _TimeLapseState extends State<TimeLapse>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late DateTime _initialTime;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    if (widget.overrideStartDateTime != null) {
      _initialTime = widget.overrideStartDateTime!;
    } else {
      _initialTime = DateTime.now();
    }
    _currentTime = _initialTime;

    _ticker = createTicker(_onTick);
    if (widget.doTick) {
      _ticker.start();
    }
  }

  void _onTick(Duration elapsedTime) {
    // elapsedTime : ticker가 처음 만들어지고 지나간 총 시간

    final newTime = _initialTime.add(elapsedTime);
    if (newTime.second != _currentTime.second) {
      setState(() {
        _currentTime = newTime;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimeLapse oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.overrideStartDateTime != oldWidget.overrideStartDateTime) {
      if (widget.overrideStartDateTime == null) {
        _initialTime = DateTime.now();
      } else {
        _initialTime = widget.overrideStartDateTime!;
      }

      _currentTime = _initialTime;

      _ticker.stop();
      if (widget.doTick) {
        _ticker.start();
      }
    } else if (widget.doTick != oldWidget.doTick) {
      if (widget.doTick) {
        _ticker.start();
      } else {
        _ticker.stop();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.dateTimeBuilder(_currentTime);
  }
}

class NewYearsCountDownPage extends StatefulWidget {
  const NewYearsCountDownPage({
    Key? key,
    required this.currentTime,
  }) : super(key: key);

  final DateTime currentTime;

  @override
  _NewYearsCountDownPageState createState() => _NewYearsCountDownPageState();
}

class _NewYearsCountDownPageState extends State<NewYearsCountDownPage> {
  final _newYearDateTime = DateTime.parse("2022-01-01 00:00:00");
  final DateFormat _timeFormat = DateFormat("h:mm:ss a");

  late ConfettiController _fireworksController;

  @override
  void initState() {
    super.initState();
    _fireworksController = ConfettiController(
      duration: const Duration(seconds: 1),
    )..play();
  }

  EnvironmentMode get envMode {
    final hours = widget.currentTime.hour;

    if (hours >= 6 && hours < 11) {
      return EnvironmentMode.morning;
    } else if (hours >= 11 && hours < 15) {
      return EnvironmentMode.afternoon;
    } else if (hours >= 15 && hours < 18) {
      return EnvironmentMode.evening;
    } else {
      return EnvironmentMode.night;
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondsUntilNewYear =
        (_newYearDateTime.difference(widget.currentTime).inMilliseconds / 1000)
            .ceil();
    return Stack(
      children: [
        LandScape(
          mode: envMode,
          time: _timeFormat.format(widget.currentTime),
          year: "${widget.currentTime.year}",
          fireworks: Align(
            alignment: const Alignment(0.0, -0.5),
            child: ConfettiWidget(
              confettiController: _fireworksController,
              displayTarget: true,
              blastDirectionality: BlastDirectionality.explosive,
              colors: [Colors.red],
              minimumSize: Size(1, 1),
              maximumSize: Size(5, 5),
              minBlastForce: 0.001,
              maxBlastForce: 0.0011,
              gravity: 0.1,
              particleDrag: 0.1,
              numberOfParticles: 35,
              emissionFrequency: 0.0000001,
              shouldLoop: false,
            ),
          ),
        ),
        CountDownText(
          secondsToNewYear: secondsUntilNewYear,
        ),
        HappyNewYearText(
          secondsToNewYear: secondsUntilNewYear,
        ),
      ],
    );
  }
}

// TODO: add count down effect
class CountDownText extends StatefulWidget {
  const CountDownText({
    Key? key,
    this.secondsToNewYear,
  }) : super(key: key);

  final int? secondsToNewYear;

  @override
  _CountDownTextState createState() => _CountDownTextState();
}

class _CountDownTextState extends State<CountDownText>
    with SingleTickerProviderStateMixin {
  late AnimationController _showNumberController;
  late Interval _opacity;
  late Interval _scale;
  late int? _displayNumber;

  @override
  void initState() {
    super.initState();
    _showNumberController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    _opacity = const Interval(0.0, 0.4);
    _scale = const Interval(0.0, 0.5, curve: Curves.elasticOut);

    _displayNumber = widget.secondsToNewYear;
    if (_isCountingDown()) {
      _showNumberController.forward();
    }
  }

  @override
  void didUpdateWidget(CountDownText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.secondsToNewYear != oldWidget.secondsToNewYear) {
      _displayNumber = widget.secondsToNewYear;
      if (_isCountingDown()) {
        _showNumberController.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _showNumberController.dispose();
    super.dispose();
  }

  bool _isCountingDown() =>
      widget.secondsToNewYear != null &&
      (widget.secondsToNewYear! <= 9 && widget.secondsToNewYear! > 0);

  @override
  Widget build(BuildContext context) {
    if (!_isCountingDown()) {
      return const SizedBox();
    }

    return Align(
      alignment: const Alignment(0.0, -0.3),
      child: Transform.scale(
        scale: _scale.transform(_showNumberController.value),
        child: Opacity(
          opacity: _opacity.transform(_showNumberController.value),
          child: Text(
            "$_displayNumber",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 240,
            ),
          ),
        ),
      ),
    );
  }
}

class HappyNewYearText extends StatefulWidget {
  const HappyNewYearText({
    Key? key,
    this.secondsToNewYear,
  }) : super(key: key);

  final int? secondsToNewYear;

  @override
  _HappyNewYearTextState createState() => _HappyNewYearTextState();
}

class _HappyNewYearTextState extends State<HappyNewYearText>
    with SingleTickerProviderStateMixin {
  late AnimationController _showHappyNewYearController;
  late Interval _opacity;
  late Interval _scale;
  int? _previousSecondsToNewYear;

  @override
  void initState() {
    super.initState();
    _showHappyNewYearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    _opacity = const Interval(0.0, 0.4);
    _scale = const Interval(0.0, 0.5, curve: Curves.elasticOut);

    _previousSecondsToNewYear = widget.secondsToNewYear;
    if (_shouldDisplayHappyNewYears()) {
      _showHappyNewYearController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant HappyNewYearText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.secondsToNewYear != oldWidget.secondsToNewYear) {
      _previousSecondsToNewYear = widget.secondsToNewYear;
      if (_shouldDisplayHappyNewYears()) {
        _showHappyNewYearController.forward();
      }
    }
  }

  @override
  void dispose() {
    _showHappyNewYearController.dispose();
    super.dispose();
  }

  bool _shouldDisplayHappyNewYears() =>
      widget.secondsToNewYear != null &&
      (widget.secondsToNewYear! <= 0 && widget.secondsToNewYear! > -5);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _shouldDisplayHappyNewYears()
          ? Align(
              alignment: const Alignment(0.0, -0.35),
              child: Transform.scale(
                scale: _scale.transform(_showHappyNewYearController.value),
                child: Opacity(
                  opacity:
                      _opacity.transform(_showHappyNewYearController.value),
                  child: const Text(
                    "HAPPY\nNEW\nYEAR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

class LandScape extends StatelessWidget {
  const LandScape({
    Key? key,
    required this.mode,
    this.fireworks = const SizedBox(),
    this.time = "",
    this.year = "",
  }) : super(key: key);

  static const switchModeDuration = Duration(milliseconds: 500);

  final EnvironmentMode mode;
  final Widget fireworks;
  final String time;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Sky(
          mode: mode,
          duration: switchModeDuration,
        ),
        Stars(mode: mode),
        fireworks,
        Mountains(
          mode: mode,
          duration: switchModeDuration,
        ),
        TimeText(
          time: time,
          year: year,
          mode: mode,
        ),
      ],
    );
  }
}

class Sky extends StatelessWidget {
  const Sky({
    Key? key,
    required this.mode,
    required this.duration,
  }) : super(key: key);

  final EnvironmentMode mode;
  final Duration duration;

  LinearGradient _buildGradient() {
    switch (mode) {
      case EnvironmentMode.morning:
        return morningGradient;
      case EnvironmentMode.afternoon:
        return afternoonGradient;
      case EnvironmentMode.evening:
        return eveningGradient;
      case EnvironmentMode.night:
        return nightGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: DecoratedBox(
        key: ValueKey(mode),
        decoration: BoxDecoration(
          gradient: _buildGradient(),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class Mountains extends StatelessWidget {
  const Mountains({
    Key? key,
    required this.mode,
    required this.duration,
  }) : super(key: key);

  final EnvironmentMode mode;
  final Duration duration;

  AssetImage get _assetImage {
    switch (mode) {
      case EnvironmentMode.morning:
        return Assets.mountainsMorning;
      case EnvironmentMode.afternoon:
        return Assets.mountainsAfternoon;
      case EnvironmentMode.evening:
        return Assets.mountainsEvening;
      case EnvironmentMode.night:
        return Assets.mountainsNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedSwitcher(
        duration: duration,
        child: Image(
          image: _assetImage,
          key: ValueKey(mode),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Stars extends StatelessWidget {
  const Stars({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final EnvironmentMode mode;

  @override
  Widget build(BuildContext context) {
    return mode == EnvironmentMode.night
        ? const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Image(
              image: Assets.stars,
              fit: BoxFit.cover,
            ))
        : const SizedBox();
  }
}

class TimeText extends StatelessWidget {
  const TimeText({
    Key? key,
    required this.time,
    required this.year,
    required this.mode,
  }) : super(key: key);

  final String time;
  final String year;
  final EnvironmentMode mode;

  Color get _textColor {
    switch (mode) {
      case EnvironmentMode.morning:
        return morningTextColor;
      case EnvironmentMode.afternoon:
        return afternoonTextColor;
      case EnvironmentMode.evening:
        return eveningTextColor;
      case EnvironmentMode.night:
        return nightTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            year,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textColor,
              fontSize: 52,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

const morningTextColor = Color(0xFF797149);
const afternoonTextColor = Color(0xFF5E576C);
const eveningTextColor = Color(0xFF832A2A);
const nightTextColor = Color(0xFF3C148C);

const morningGradient = LinearGradient(
  colors: [
    Color(0xFFFAE81C),
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const afternoonGradient = LinearGradient(
  colors: [
    Color(0xFF0D71F9),
    Colors.white,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const eveningGradient = LinearGradient(
  colors: [
    Color(0xFFBC3100),
    Color(0xFFE04F08),
    Color(0xFFFF8A00),
    Color(0xFFFFC888),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const nightGradient = LinearGradient(
  colors: [
    Color(0xFF19142a),
    Color(0xFF3f2b87),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

enum EnvironmentMode {
  morning,
  afternoon,
  evening,
  night,
}
