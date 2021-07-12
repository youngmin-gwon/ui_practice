import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screen/login_signup_page.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Signup UI',
      home: Scaffold(
        body: LoginSignupPage(),
      ),
    );
  }
}
