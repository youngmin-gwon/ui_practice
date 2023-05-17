import 'package:animation_practice/balloon_animation/balloon_page.dart';
import 'package:animation_practice/celebration_animation/new_year_celebration_page.dart';
import 'package:animation_practice/cli_ui/cli_ui.dart';
import 'package:animation_practice/face_pile/face_pile_animation.dart';
import 'package:animation_practice/kinetic_poster_animation/kinetic_poster_example.dart';
import 'package:animation_practice/milk_glass/milk_glass_screen.dart';
import 'package:animation_practice/page_indicator/page_indicator_example.dart';
import 'package:animation_practice/practice/practice_home.dart';
import 'package:animation_practice/spring_animation/spring_challenge.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      builder: (context) => const KineticPosterExamplePage(),
                    ),
                  ),
                  child: const Text("Kinetic poster example"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CommandLinePage(),
                    ),
                  ),
                  child: const Text("CLI-styled"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BalloonPage(),
                    ),
                  ),
                  child: const Text("Balloon Animation"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewYearCelebrationScreen(),
                    ),
                  ),
                  child: const Text("New Year Celebration Animation"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MilkGlassScreen(),
                    ),
                  ),
                  child: const Text("Glass of Milk(Custom Painter)"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PracticeHomePage(),
                    ),
                  ),
                  child: const Text("Practice Page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
