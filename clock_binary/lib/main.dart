import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.black38,
            fontSize: 30,
          ),
        ),
      ),
      home: const Scaffold(
        body: Clock(),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  BinaryTime _now = BinaryTime();

  // Tick the clock
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = BinaryTime();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClockColumn(
            binaryInteger: _now.hourTens,
            title: "H",
            color: Colors.blue,
            rows: 2,
          ),
          ClockColumn(
            binaryInteger: _now.hourOnes,
            title: "h",
            color: Colors.lightBlue,
          ),
          ClockColumn(
            binaryInteger: _now.minuteTens,
            title: "M",
            color: Colors.green,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.minuteOnes,
            title: "m",
            color: Colors.lightGreen,
          ),
          ClockColumn(
            binaryInteger: _now.secondTens,
            title: "S",
            color: Colors.pink,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.secondOnes,
            title: "s",
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}

class ClockColumn extends StatelessWidget {
  ClockColumn({
    Key? key,
    required this.binaryInteger,
    required this.title,
    required this.color,
    this.rows = 4,
  }) : super(key: key) {
    bits = binaryInteger.split("");
  }

  final String binaryInteger;
  final String title;
  final Color color;
  final int rows;
  late List<String> bits;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      ...bits.mapIndexed(
        (idx, bit) {
          bool isActive = bit == '1';
          int binaryCellValue = pow(2, 3 - idx).toInt();

          return AnimatedContainer(
            duration: const Duration(milliseconds: 475),
            curve: Curves.ease,
            height: 40,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isActive
                  ? color
                  : idx < 4 - rows
                      ? Colors.white.withOpacity(0)
                      : Colors.black,
            ),
            child: Center(
              child: isActive
                  ? Text(
                      binaryCellValue.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(.2),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
      Text(
        int.parse(binaryInteger, radix: 2).toString(),
        style: TextStyle(fontSize: 30, color: color),
      ),
      Text(
        binaryInteger,
        style: TextStyle(fontSize: 15, color: color),
      ),
    ]);
  }
}

// Utility class to access values as binary integers
class BinaryTime {
  late List<String> binaryIntegers;

  BinaryTime() {
    DateTime now = DateTime.now();
    String hhmmss = DateFormat("Hms").format(now).replaceAll(":", "");

    binaryIntegers = hhmmss
        .split("")
        .map((str) => int.parse(str).toRadixString(2).padLeft(4, '0'))
        .toList();
  }

  get hourTens => binaryIntegers[0];
  get hourOnes => binaryIntegers[1];
  get minuteTens => binaryIntegers[2];
  get minuteOnes => binaryIntegers[3];
  get secondTens => binaryIntegers[4];
  get secondOnes => binaryIntegers[5];
}
