import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/providers/color_notifier.dart';

final colorNotifierProvider =
    StateNotifierProvider<ColorNotifier, Color>((ref) => ColorNotifier());
