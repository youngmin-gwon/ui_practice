import 'package:flutter/material.dart';
import 'package:nike_shop_ui/domain/mock_products.dart';
import 'package:nike_shop_ui/gen/assets.gen.dart';
import 'package:nike_shop_ui/presentation/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double? _currentPage = 0;
  String _productCategory = "TRAINING";

  late AnimationController _animationController;
  Animation<Offset>? _searchOffsetAnimation;
  Animation<Offset>? _cardOffsetAnimation;
  late Animation<double> _nikeLogoOffsetAnimation;
  Animation<Offset>? _productBackgroundOffsetAnimation;
  Animation<Offset>? _productOffsetAnimation;

  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
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

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: AppBar(
          leading: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          backgroundColor: const Color(0xFFF3F3F3),
          elevation: 0,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12),
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
                  children: <Widget>[
                    Container(
                      height: size.height * 0.60,
                      width: size.width,
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: mockProducts.length,
                        controller: _pageController,
                        itemBuilder: (BuildContext context, int index) {
                          _productCategory = mockProducts[index].category;

                          if (index == _currentPage!.floor()) {
                            return CardView(
                              product: mockProducts[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerRight,
                            );
                          } else if (index == _currentPage!.floor() + 1) {
                            return CardView(
                              product: mockProducts[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerLeft,
                            );
                          } else {
                            return CardView(
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
                    height: 100,
                    width: 50,
                    child: Image(image: Assets.nikeLogo),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 48,
                      left: 32,
                      right: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Icon(
                          Icons.arrow_back,
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
                            _productCategory.toUpperCase(),
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
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        )));
  }
}
