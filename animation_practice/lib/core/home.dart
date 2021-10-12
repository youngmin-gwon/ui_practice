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
                      builder: (context) => SpringChallenge(),
                    ),
                  ),
                  child: const Text("Spring Animation"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
