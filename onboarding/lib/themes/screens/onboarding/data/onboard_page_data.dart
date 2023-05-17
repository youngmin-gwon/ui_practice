import 'dart:ui';

import 'package:onboarding/themes/screens/onboarding/models/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
    const Color(0xFFE6E6E6),
    const Color(0xFF005699),
    const Color(0xFFFFE074),
    0,
    'assets/images/flutter_onboarding_1.png',
    'EXPLORING',
    'FLUTTER',
    'On this channel we try and build fun stuff using Flutter and Dart. Subscribe for more content and let me know what you think in the comments!',
  ),
  OnboardPageModel(
    const Color(0xFF005699),
    const Color(0xFFFFE074),
    const Color(0xFF39393A),
    1,
    'assets/images/flutter_onboarding_2.png',
    'ANIMATING',
    'FLARE',
    'Making Flare animations and incorporating it into Flutter. Mobile animations have never been so easy!',
  ),
  OnboardPageModel(
    const Color(0xFFFFE074),
    const Color(0xFF39393A),
    const Color(0xFFE6E6E6),
    2,
    'assets/images/flutter_onboarding_3.png',
    'DESIGN AND',
    'ANIMATION',
    'Recreating and imagining our own designs and animations to create custom effects and widgets.',
  ),
  OnboardPageModel(
    const Color(0xFF39393A),
    const Color(0xFFE6E6E6),
    const Color(0xFF005699),
    3,
    'assets/images/flutter_onboarding_4.png',
    'EDUCATIONAL',
    'PROGRAMMING',
    'Learn coding with examples, in a fun, somewhat structured, way. Enjoy!',
  ),
];
