import 'package:flutter/material.dart';

import 'beginner/beginner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BeginnerLevelPage(),
                    ));
              },
              child: const Text("Beginner Level"),
            ),
          ],
        ),
      ),
    );
  }
}