import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_shop_ui/domain/mock_products.dart';
import 'package:nike_shop_ui/gen/assets.gen.dart';
import 'package:nike_shop_ui/presentation_practice/card_practice.dart';

class HomePracticePage extends StatefulWidget {
  const HomePracticePage({Key? key}) : super(key: key);

  @override
  _HomePracticePageState createState() => _HomePracticePageState();
}

class _HomePracticePageState extends State<HomePracticePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _nikeLogoOffsetAnimation;
  late PageController _pageController;
  late String _category;

  double? _currentPage = 0;

  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage!.toInt(),
    )..addListener(() {
        setState(() {
          _currentPage = _pageController.page;
        });
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _nikeLogoOffsetAnimation = Tween<double>(
      begin: -1000,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    _category = mockProducts[_currentPage!.floor()].category;

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF3F3F3),
        leading: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: size.height * .6,
                      width: size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: mockProducts.length,
                        onPageChanged: (index) {
                          setState(() {
                            _category = mockProducts[index].category;
                          });
                        },
                        itemBuilder: (context, index) {
                          if (index == _currentPage!.floor()) {
                            return CardPractice(
                              product: mockProducts[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerRight,
                            );
                          } else if (index == _currentPage!.floor() + 1) {
                            return CardPractice(
                              product: mockProducts[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerLeft,
                            );
                          } else {
                            return CardPractice(
                              product: mockProducts[index],
                              index: index,
                              page: _currentPage,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(
                    size.width / 2 - 25,
                    _nikeLogoOffsetAnimation.value,
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(image: Assets.nikeLogo),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 32,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 16,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isAnimated = !_isAnimated;
                            });

                            if (_isAnimated) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: Text(
                            _category.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
