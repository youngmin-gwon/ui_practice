import 'package:animation_practice/practice/kinetic_poster/kinetic_poster_practice.dart';
import 'package:animation_practice/practice/page_indicator/indicator_practice.dart';
import 'package:flutter/material.dart';

class PracticeHomePage extends StatelessWidget {
  const PracticeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Repository"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IndicatorPracticePage(),
                    ),
                  ),
                  child: const Text("Indicator Animation"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const KineticPosterPracticePage(),
                    ),
                  ),
                  child: const Text("Kinetic Poster Animation"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
