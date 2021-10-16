import 'package:flutter/material.dart';

class PageIndicatorExamplePage extends StatefulWidget {
  const PageIndicatorExamplePage({Key? key}) : super(key: key);

  @override
  State<PageIndicatorExamplePage> createState() =>
      _PageIndicatorExamplePageState();
}

class _PageIndicatorExamplePageState extends State<PageIndicatorExamplePage> {
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
            child: PageIndicator(
              pageController: _pageController,
            ),
          )
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          return CustomPaint(
            painter: PageIndicatorPainter(
              pageCount: 3,
              dotRadius: 10,
              dotOutlineThickness: 3,
              spacing: 25,
              dotFillColor: const Color(0x0F000000),
              dotOutlineColor: const Color(0x20000000),
              indicatorColor: Colors.indigo,
              scrollPosition:
                  pageController.hasClients && pageController.page != null
                      ? pageController.page!
                      : 0.0,
            ),
          );
        });
  }
}

class PageIndicatorPainter extends CustomPainter {
  final int pageCount;
  final double dotRadius;
  final double spacing;
  final double scrollPosition;
  final double dotOutlineThickness;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;

  PageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    required this.spacing,
    this.scrollPosition = 0.0,
    required Color dotFillColor,
    required Color dotOutlineColor,
    required Color indicatorColor,
  })  : dotFillPaint = Paint()..color = dotFillColor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final double totalWidth =
        (pageCount * (dotRadius * 2)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);

    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final int pageIndexToLeft = scrollPosition.floor();
    final double leftDotX = (center.dx - (totalWidth / 2)) +
        (pageIndexToLeft * ((2 * dotRadius) + spacing));
    final double transitionPercent = scrollPosition - pageIndexToLeft;

    final double laggingLeftPositionPercent =
        (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;

    final double indicatorLeftX =
        leftDotX + (laggingLeftPositionPercent * ((2 * dotRadius) + spacing));

    final double acceleratedRightPositionPercent =
        (transitionPercent / 0.5).clamp(0.0, 1.0);

    final double indicatorRightX = leftDotX +
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
    Offset dotCenter = center.translate((-totalWidth / 2) + dotRadius, 0);

    for (var i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);

      dotCenter = dotCenter.translate(2 * dotRadius + spacing, 0);
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
  bool shouldRepaint(PageIndicatorPainter oldDelegate) {
    return true;
  }
}

class OTTPage extends StatelessWidget {
  const OTTPage({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.imageAsset,
    required this.title,
  }) : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                imageAsset,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w300,
                fontSize: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
