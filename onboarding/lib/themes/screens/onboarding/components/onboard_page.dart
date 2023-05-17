import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/providers/provider.dart';
import 'package:onboarding/themes/screens/onboarding/components/drawer_paint.dart';
import 'package:onboarding/themes/screens/onboarding/data/onboard_page_data.dart';
import 'package:onboarding/themes/screens/onboarding/models/onboard_page_model.dart';

class OnboardPage extends ConsumerStatefulWidget {
  final PageController pageController;
  final OnboardPageModel pageModel;

  const OnboardPage({
    Key? key,
    required this.pageController,
    required this.pageModel,
  }) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends ConsumerState<OnboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> heroAnimation;
  late Animation<double> borderAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    heroAnimation = Tween<double>(begin: -40, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
    );

    borderAnimation = Tween<double>(begin: 75, end: 50).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
    );

    animationController.forward(from: 0);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _nextButtonPressed() {
    if (widget.pageController.page != onboardData.length - 1) {
      ref.watch(colorNotifierProvider.notifier).color =
          widget.pageModel.nextAccentColor;
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: widget.pageModel.primeColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: heroAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(heroAnimation.value, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Image.asset(widget.pageModel.imagePath),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          widget.pageModel.caption,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 24,
                                    color: widget.pageModel.accentColor
                                        .withOpacity(.8),
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          widget.pageModel.subhead,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 32,
                                    color: widget.pageModel.accentColor,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          widget.pageModel.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 22,
                                    color: widget.pageModel.accentColor
                                        .withOpacity(.9),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: borderAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: DrawerPaint(
                  curveColor: widget.pageModel.accentColor,
                ),
                child: SizedBox(
                  width: borderAnimation.value,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: widget.pageModel.primeColor,
                          size: 32,
                        ),
                        onPressed: _nextButtonPressed,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
