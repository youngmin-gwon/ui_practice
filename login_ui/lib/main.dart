import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screen/message_flash.dart';
import 'package:flutter_login_ui/screen/sign_in_page.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignIn UI',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _errorId = 0;

  void _onError() {
    setState(() {
      _errorId = (_errorId + 1) * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilt!");
    return SignInPage(
      errorDisplay: MessageFlash(
        flashId: _errorId.toString(),
        color: Colors.red,
        child: Text("An error occurred"),
      ),
      onError: _onError,
    );
  }
}
