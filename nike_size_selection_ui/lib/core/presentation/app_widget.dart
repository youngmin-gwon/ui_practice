import 'package:flutter/material.dart';
import 'package:nike_size_selection_ui/core/presentation/constants/theme_constants.dart';
import 'package:nike_size_selection_ui/home/presentation/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
