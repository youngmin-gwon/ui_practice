import 'package:flutter/material.dart';
import 'package:nike_shop_ui/presentation/home.dart';

void main() => runApp(const AppWidget());

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Nike Shop",
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: const HomePage());
  }
}
