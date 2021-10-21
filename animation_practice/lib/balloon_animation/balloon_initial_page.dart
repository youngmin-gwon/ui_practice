import 'package:animation_practice/balloon_animation/balloon_page.dart';
import 'package:animation_practice/balloon_animation/bouncing_button.dart';
import 'package:flutter/material.dart';

enum BallonState {
  initial,
  start,
  end,
}

class BalloonInitialPage extends StatefulWidget {
  const BalloonInitialPage({Key? key}) : super(key: key);

  @override
  State<BalloonInitialPage> createState() => _BalloonInitialPageState();
}

class _BalloonInitialPageState extends State<BalloonInitialPage> {
  BallonState _currentState = BallonState.initial;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "Cloud Storage",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            if (_currentState == BallonState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ),
                  onEnd: () {
                    setState(() {
                      _currentState = BallonState.end;
                    });
                  },
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "uploading files",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ProgressCount(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (_currentState != BallonState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: 1.0,
                      end: _currentState != BallonState.initial ? 0.0 : 1.0),
                  onEnd: () {
                    setState(() {
                      _currentState = BallonState.end;
                    });
                  },
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0.0, 50 * value),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text("last backup"),
                      const SizedBox(height: 10),
                      Text(
                        "28 may 2020",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOutExpo,
              switchOutCurve: Curves.easeInOutExpo,
              child: _currentState == BallonState.initial
                  ? SizedBox(
                      width: double.infinity,
                      child: BouncingButton(
                        onPressed: () {
                          setState(() {
                            _currentState = BallonState.start;
                          });
                        },
                        borderRadius: 10,
                        backgroundColor: mainColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "Create Backup",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentState = BallonState.initial;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 40.0),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProgressCount extends StatelessWidget {
  const ProgressCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
