import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/providers/provider.dart';
import 'package:onboarding/themes/screens/onboarding/components/onboard_page.dart';
import 'package:onboarding/themes/screens/onboarding/components/page_view_indicator.dart';
import 'package:onboarding/themes/screens/onboarding/data/onboard_page_data.dart';

class OnBoarding extends ConsumerStatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends ConsumerState<OnBoarding> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    pageController.addListener(onPageChanged);
  }

  void onPageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = ref.watch(colorNotifierProvider);

    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OnboardPage(
              pageModel: onboardData[index],
              pageController: pageController,
            );
          },
          itemCount: onboardData.length,
        ),
        Container(
          width: double.infinity,
          height: 80,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    "fun with",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: color,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: color,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 40),
            child: PageViewIndicator(
              controller: pageController,
              itemCount: onboardData.length,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
