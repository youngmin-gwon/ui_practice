import 'package:animation_practice/page_indicator/page_indicator_example.dart';
import 'package:flutter/material.dart';

class IndicatorPracticePage extends StatefulWidget {
  const IndicatorPracticePage({super.key});

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
              const OTTPage(
                backgroundColor: Colors.white,
                textColor: Colors.pink,
                imageAsset: "assets/watcha.png",
                title: "Watcha",
              ),
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
              const OTTPage(
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
            child: PageIndicatorPractice(
              pageController: _pageController,
            ),
          )
        ],
      ),
    );
  }
}

class PageIndicatorPractice extends StatelessWidget {
  const PageIndicatorPractice({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, snapshot) {
          return CustomPaint(
            painter: IndicatorPainter(
              pageCount: 6,
              dotRadius: 10,
              dotOutlineThickness: 3,
              scrollPosition:
                  pageController.hasClients && pageController.page != null
                      ? pageController.page!
                      : 0.0,
              spacing: 25,
              dotOutlineColor: const Color(0x20000000),
              dotFillColor: const Color(0x0F000000),
              indicatorColor: Colors.indigo,
            ),
          );
        },);
  }
}

class IndicatorPainter extends CustomPainter {
  final int pageCount;
  final double dotRadius;
  final double dotOutlineThickness;
  final double scrollPosition;
  final double spacing;
  final Paint dotOutlinePaint;
  final Paint dotFillPaint;
  final Paint indicatorPaint;

  final int maxShownCount;

  IndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    this.scrollPosition = 0.0,
    required this.spacing,
    required Color dotOutlineColor,
    required Color dotFillColor,
    required Color indicatorColor,
    this.maxShownCount = 5,
  })  : dotOutlinePaint = Paint()..color = dotOutlineColor,
        dotFillPaint = Paint()..color = dotFillColor,
        indicatorPaint = Paint()..color = indicatorColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final totalWidth =
        (pageCount * (2 * dotRadius)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);

    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final pageIndexToLeft = scrollPosition.floor();

    final leftDotX = (center.dx - totalWidth / 2) +
        (pageIndexToLeft * ((2 * dotRadius) + spacing));
    final transitionPercent = scrollPosition - pageIndexToLeft;

    final laggingLeftPositionPercent =
        (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;

    final indicatorLeftX =
        leftDotX + (laggingLeftPositionPercent * ((2 * dotRadius) + spacing));

    final acceleratedRightPositionPercent =
        (transitionPercent / 0.5).clamp(0.0, 1.0);

    final indicatorRightX = leftDotX +
        (acceleratedRightPositionPercent * ((2 * dotRadius) + spacing)) +
        (2 * dotRadius);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        -dotRadius,
        indicatorRightX,
        dotRadius,
        Radius.circular(dotRadius),
      ),
      indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWidth) {
    Offset dotCenter = center.translate(-(totalWidth / 2) + dotRadius, 0);

    for (var i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);

      dotCenter = dotCenter.translate((2 * dotRadius) + spacing, 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(dotCenter, dotRadius - dotOutlineThickness, dotFillPaint);

    final outlinePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: dotCenter,
          radius: dotRadius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: dotCenter,
          radius: dotRadius - dotOutlineThickness,
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
