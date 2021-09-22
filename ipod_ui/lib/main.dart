import 'package:flutter/material.dart';

import 'package:ipod_ui/domain/mock_album_data.dart';

import 'domain/album.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  double? _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: _currentPage!.toInt(),
    )..addListener(() {
        setState(() {
          _currentPage = _pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF686868),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black87,
                ),
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: mockAlbums.length,
                  itemBuilder: (context, index) {
                    return AlbumCard(
                      currentIndex: index,
                      currentPage: _currentPage,
                      album: mockAlbums[index],
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onPanUpdate: _panHandler,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 32),
                            child: Text(
                              "menu".toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 12),
                            child: IconButton(
                              onPressed: () => _pageController.animateToPage(
                                (_pageController.page! - 1).toInt(),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              ),
                              iconSize: 40,
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(right: 12),
                            child: IconButton(
                              onPressed: () => _pageController.animateToPage(
                                (_pageController.page! + 1).toInt(),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              ),
                              iconSize: 40,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white38,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _panHandler(DragUpdateDetails d) {
    double radius = 150;

    // pan location on the wheel
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    // pan movemoents
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    // absolute chage on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    // directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;
    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // total computed change
    double rotationalChange =
        (verticalRotation + horizontalRotation) * (d.delta.distance * 0.2);

    // move the page view scroller
    _pageController.jumpTo(_pageController.offset + rotationalChange);
  }
}

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    this.currentPage,
    required this.currentIndex,
    required this.album,
  }) : super(key: key);

  final double? currentPage;
  final int currentIndex;
  final Album album;

  @override
  Widget build(BuildContext context) {
    double relativePosition = currentIndex - currentPage!;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.003)
        ..scale((1 - relativePosition.abs()).clamp(0.2, 0.6) + 0.4)
        ..rotateY(relativePosition),
      alignment:
          relativePosition >= 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: album.coverImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
