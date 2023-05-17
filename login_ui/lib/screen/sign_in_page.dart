import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
    void Function()? onError,
    required this.errorDisplay,
  })  : _onError = onError,
        super(key: key);

  void Function()? _onError;
  final Widget errorDisplay;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: formKey,
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "sign in".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "email",
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "password",
                    ),
                  ),
                  SizedBox(height: 25),
                  errorDisplay,
                  SizedBox(height: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    onPressed: () {
                      _onError?.call();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
