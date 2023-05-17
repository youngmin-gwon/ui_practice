import 'package:flutter/material.dart';
import 'package:nike_size_selection_ui/core/presentation/assets/assets.gen.dart';
import 'package:nike_size_selection_ui/home/presentation/widgets/cta_button.dart';
import 'package:nike_size_selection_ui/home/presentation/widgets/product_showcase.dart';
import 'package:nike_size_selection_ui/home/presentation/widgets/product_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _nikeLogoScaleAnimation;
  late Animation<Offset> _nikeLogoOffsetAnimation;
  late Animation<double> _leftBackgroundWidthAnimation;
  late Animation<double> _rightBackgroundWidthAnimation;
  late Animation<Offset> _productNameOffsetAnimation;
  late Animation<Offset> _productPriceOffsetAnimation;
  late Animation<Offset> _productSliderOffsetAnimation;
  late Animation<Offset> _productDescriptionOffsetAnimation;
  late Animation<Offset> _ctaOffsetAnimation;
  late Animation<Offset> _productShowcaseOffsetAnimation;
  late Animation<Offset> _display1OffsetAnimation;
  late Animation<Offset> _display2OffsetAnimation;
  late Animation<Offset> _display3OffsetAnimation;

  double _shoeSize = 39;
  bool _isAnimationTriggered = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _nikeLogoScaleAnimation = Tween<double>(begin: 2.5, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _nikeLogoOffsetAnimation = Tween<Offset>(
      begin: const Offset(150, 110),
      end: const Offset(20, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.125,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _leftBackgroundWidthAnimation = Tween<double>(
      begin: 0,
      end: 400,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _rightBackgroundWidthAnimation = Tween<double>(
      begin: 900,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _productNameOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1000),
      end: const Offset(0, 125),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          0.750,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _productPriceOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1000),
      end: const Offset(0, 200),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.125,
          0.800,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _productSliderOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1000),
      end: const Offset(0, 300),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.250,
          0.900,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _productDescriptionOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1000),
      end: const Offset(0, 375),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.350,
          0.950,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _ctaOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1000),
      end: const Offset(0, 500),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.450,
          1,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _productShowcaseOffsetAnimation = Tween<Offset>(
      begin: const Offset(3000, 20),
      end: const Offset(0, 20),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          0.750,
          curve: Curves.ease,
        ),
      ),
    );

    _display1OffsetAnimation = Tween<Offset>(
      begin: const Offset(3000, 450),
      end: const Offset(60, 450),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.125,
          0.500,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _display2OffsetAnimation = Tween<Offset>(
      begin: const Offset(3000, 450),
      end: const Offset(160, 450),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.350,
          0.850,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _display3OffsetAnimation = Tween<Offset>(
      begin: const Offset(3000, 450),
      end: const Offset(260, 450),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.450,
          0.950,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040404),
      body: Stack(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: const Color(0xFF0D0D0D),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: const Color(0xFF101010),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: const Color(0xFF202020),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: const Color(0xFFFF2D4C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 650,
                            width: 900,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: const Color(0xFF121212),
                                  width: _leftBackgroundWidthAnimation.value,
                                ),
                                Container(
                                  color: const Color(0xFF0D0D0D),
                                  width: _rightBackgroundWidthAnimation.value,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 650,
                            width: 900,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 650,
                                  width: 400,
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Stack(
                                    children: <Widget>[
                                      Transform.translate(
                                        offset:
                                            _productNameOffsetAnimation.value,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SelectableText(
                                              'NIKE MAG FROM "BACK TO THE FUTURE"',
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SelectableText(
                                              'BUILT FOR "FUTURE"',
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Transform.translate(
                                        offset:
                                            _productPriceOffsetAnimation.value,
                                        child: const SelectableText(
                                          '\$150',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 48,
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset:
                                            _productSliderOffsetAnimation.value,
                                        child: ProductSlider(
                                          min: 39,
                                          max: 45,
                                          divisions: 6,
                                          sliderValue: _shoeSize,
                                          sliderSteps: const [
                                            39,
                                            40,
                                            41,
                                            42,
                                            43,
                                            44,
                                            45,
                                          ],
                                          onValueChanged: (value) {
                                            setState(() {
                                              _shoeSize = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset:
                                            _productDescriptionOffsetAnimation
                                                .value,
                                        child: const SelectableText(
                                          "There's no player more battle-tested than LeBron James. Build for speed, with responsive cushioning and lightweight lockdown, the Lebron Soldier XIII is the next iteration of custom reinforcement for on-court dominance.",
                                          style: TextStyle(
                                            color: Color(0xFF909090),
                                            fontSize: 10,
                                            height: 2,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: _ctaOffsetAnimation.value,
                                        child: CtaButton(
                                          title: 'Buy Now',
                                          onCtaTap: (isTapped) {
                                            // TODO: UX/logic setup for demo only :)
                                            // Show some delay
                                            Future.delayed(
                                              const Duration(seconds: 1),
                                              () {
                                                setState(() {
                                                  _isAnimationTriggered =
                                                      !_isAnimationTriggered;
                                                });

                                                _animationController.reverse();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 500,
                                  height: 650,
                                  child: Stack(
                                    children: <Widget>[
                                      Transform.translate(
                                        offset: _productShowcaseOffsetAnimation
                                            .value,
                                        child: SizedBox(
                                          height: 450,
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                child: ProductShowcase(
                                                  productSize: _shoeSize,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: _display1OffsetAnimation.value,
                                        child: Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.black87,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(37.5),
                                          ),
                                          child: const ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(37.5),
                                            ),
                                            child:
                                                Image(image: Assets.nikeBack),
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: _display2OffsetAnimation.value,
                                        child: Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.black87,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(37.5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(37.5),
                                            child: const Image(
                                                image: Assets.nikeAirview),
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: _display3OffsetAnimation.value,
                                        child: Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.black87,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(37.5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(37.5),
                                            child: const Image(
                                              image: Assets.nikeDetails,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: _nikeLogoScaleAnimation.value,
                            child: Transform.translate(
                              offset: _nikeLogoOffsetAnimation.value,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isAnimationTriggered =
                                        !_isAnimationTriggered;
                                  });

                                  if (_isAnimationTriggered) {
                                    _animationController.forward();
                                  } else {
                                    _animationController.reverse();
                                  }
                                },
                                child: const SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image(image: Assets.nikeLogo),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
