import 'package:flutter/material.dart';
import 'package:shimmer_effect/shimmer/loading_ui_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingUiAnimation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
