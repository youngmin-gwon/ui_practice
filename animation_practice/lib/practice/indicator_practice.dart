import 'package:animation_practice/page_indicator/page_indicator_example.dart';
import 'package:flutter/material.dart';

class IndicatorPracticePage extends StatefulWidget {
  const IndicatorPracticePage({Key? key}) : super(key: key);

  @override
  _IndicatorPracticePageState createState() => _IndicatorPracticePageState();
}

class _IndicatorPracticePageState extends State<IndicatorPracticePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OTTPage(
                backgroundColor: Colors.black.withOpacity(.7),
                textColor: Colors.white,
                imageAsset: "assets/netflix.png",
                title: "Netflix",
              ),
              OTTPage(
                backgroundColor: Colors.blue.shade900,
                textColor: Colors.white,
                imageAsset: "assets/disney_plus.png",
                title: "Disney +",
              ),
              OTTPage(
                backgroundColor: Colors.white,
                textColor: Colors.pink,
                imageAsset: "assets/watcha.png",
                title: "Watcha",
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            left: 0,
            right: 0,
            child: PageIndicatorPractice(),
          )
        ],
      ),
    );
  }
}

class PageIndicatorPractice extends StatelessWidget {
  const PageIndicatorPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 16,
    );
  }
}
