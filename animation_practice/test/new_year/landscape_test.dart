import 'package:animation_practice/celebration_animation/new_year_celebration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_tools.dart';

void main() {
  group(
    "New Year Celebration Widget Test",
    () {
      testGoldens(
        "Landscape Test",
        (tester) async {
          configureToLookLikeIPhone11(tester);

          await tester.pumpWidget(_buildLandscape(EnvironmentMode.morning));
          await screenMatchesGolden(tester, "landscape_morning");

          await tester.pumpWidget(_buildLandscape(EnvironmentMode.afternoon));
          await screenMatchesGolden(tester, "landscape_afternoon");

          await tester.pumpWidget(_buildLandscape(EnvironmentMode.evening));
          await screenMatchesGolden(tester, "landscape_evening");

          await tester.pumpWidget(_buildLandscape(EnvironmentMode.night));
          await screenMatchesGolden(tester, "landscape_night");
        },
      );
    },
  );
}

Widget _buildLandscape(EnvironmentMode mode) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: LandScape(mode: mode),
    ),
  );
}
