import 'package:flutter/material.dart';
import 'package:nike_shop_ui/domain/mock_products.dart';
import 'package:nike_shop_ui/gen/assets.gen.dart';
import 'package:nike_shop_ui/presentation_practice/card_practice.dart';

class HomePracticePage extends StatelessWidget {
  const HomePracticePage({Key? key}) : super(key: key);

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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: size.height * .6,
                  width: size.width,
                  child: const CardPage(),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
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
                    Text(
                      "test".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
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
        ),
      ),
    );
  }
}

class CardPage extends StatefulWidget {
  const CardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late PageController _pageController;

  double? _currentPage = 0;

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: mockProducts.length,
      onPageChanged: (index) {},
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
    );
  }
}
