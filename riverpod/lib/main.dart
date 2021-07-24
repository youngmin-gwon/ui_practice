import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      // overrides: [], // overrides: testing 에 좋음
      // observers: [], // observers: logging 에 좋음
      child: MaterialApp(
        title: 'Material App',
        initialRoute: "/",
        routes: {
          "/": (context) => Home(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
