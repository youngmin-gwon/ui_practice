import 'package:animation_practice/animated_widget_page.dart';
import 'package:animation_practice/basic_animation_page.dart';
import 'package:animation_practice/stagger_demo_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: StaggerDemo());
  }
}
