import 'package:flutter/material.dart';
import 'package:flutter_login_ui/config/palette.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRemeberMe = false;

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
              ]),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange[200]!,
                  Colors.red[400]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(0.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Welcome to",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? " Rizona " : " Back, ",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isSignupScreen
                          ? "Signup to Continue"
                          : "Sign In to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Main Container for Login and Signup
          buildBottomHalfContainer(true),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(microseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Palette.textColor1
                                      : Palette.activeColor,
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection(),
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom button
          Positioned(
              top: MediaQuery.of(context).size.height - 150,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    isSignupScreen ? "Or Signup with" : "Or Signin with",
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTextButton(
                            Icons.facebook, "Facebook", Palette.facebookColor),
                        buildTextButton(
                            Icons.g_mobiledata, "Google", Palette.googleColor),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "info@demouri.com", false, true),
          buildTextField(Icons.lock_outline, "***********", true, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isRemeberMe,
                      onChanged: (value) {
                        setState(() {
                          isRemeberMe = !isRemeberMe;
                        });
                      }),
                  Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: 12,
                      color: Palette.textColor1,
                    ),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Palette.textColor1,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.account_box_outlined, "User Name", false, false),
          buildTextField(Icons.email_outlined, "email", false, true),
          buildTextField(Icons.lock_outline, "password", true, false),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isMale ? Palette.textColor2 : null,
                          border: Border.all(
                            width: 1,
                            color: Palette.textColor1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.person,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: !isMale ? Palette.textColor2 : null,
                          border: Border.all(
                            width: 1,
                            color: Palette.textColor1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.person,
                          color: !isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 230,
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By pressing 'Submit' you agree to our ",
                style: TextStyle(color: Palette.textColor2),
                children: [
                  TextSpan(
                    text: "term & conditions",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(155, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            SizedBox(width: 5),
            Text(title)
          ],
        ));
  }
}

Widget buildTextField(
    IconData icon, String hintText, bool isPassword, bool isEmail) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextField(
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Palette.iconColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.textColor1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.textColor1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Palette.textColor1,
        ),
      ),
    ),
  );
}
