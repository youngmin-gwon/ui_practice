import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/themes/screens/onboarding/data/onboard_page_data.dart';

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier() : super(onboardData[0].accentColor);

  Color get color => state;

  set color(Color color) {
    state = color;
  }
}
