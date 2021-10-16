import 'package:animation_practice/face_pile/face_pile_animation.dart';
import 'package:animation_practice/page_indicator/page_indicator_example.dart';
import 'package:animation_practice/practice/indicator_practice.dart';
import 'package:animation_practice/spring_animation/spring_challenge.dart';
import 'package:animation_practice/staggered_animation/stagger_demo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StaggerDemo(),
                    ),
                  ),
                  child: const Text("Staggered Animation"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SpringChallenge(),
                    ),
                  ),
                  child: const Text("Spring Animation"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FacePilePage(),
                    ),
                  ),
                  child: const Text("Face Pile Animation"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageIndicatorExamplePage(),
                    ),
                  ),
                  child: const Text("Page Indicator Example"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IndicatorPracticePage(),
                    ),
                  ),
                  child: const Text("Indicator Practice page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
