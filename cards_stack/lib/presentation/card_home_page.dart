import 'dart:math';
import 'dart:ui';

import 'package:cards_stack/presentation/cards_details.dart';
import 'package:flutter/material.dart';

import 'package:cards_stack/domain/card.dart';

class CardsHome extends StatelessWidget {
  const CardsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          title: const Text(
            "My Playlist",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.menu,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: const Column(
          children: [
            Expanded(
              flex: 3,
              child: CardsBody(),
            ),
            Expanded(
              flex: 2,
              child: CardHorizontal(),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}

class CardsBody extends StatefulWidget {
  const CardsBody({Key? key}) : super(key: key);

  @override
  State<CardsBody> createState() => _CardsBodyState();
}

class _CardsBodyState extends State<CardsBody> with TickerProviderStateMixin {
  bool _selectedMode = false;
  late AnimationController _animationControllerSelected;
  late AnimationController _animationControllerMovement;
  int? _selectedIndex;

  Future<void> _onCardSelected(Card3D card, int index) async {
    setState(() {
      _selectedIndex = index;
    });
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (context, animation, _) => FadeTransition(
            opacity: animation,
            child: CardsDetails(
              card: card,
            )),
      ),
    );

    _animationControllerMovement.reverse(from: 1.0);
  }

  int _getCurrentFactor(int currentIndex) {
    if (_selectedIndex == null || currentIndex == _selectedIndex) {
      return 0;
    } else if (currentIndex > _selectedIndex!) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationControllerSelected = AnimationController(
      vsync: this,
      lowerBound: 0.15,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 500),
    );
    _animationControllerMovement = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 880),
    );
  }

  @override
  void dispose() {
    _animationControllerSelected.dispose();
    _animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ccontext, constraints) {
        return AnimatedBuilder(
            animation: _animationControllerSelected,
            builder: (context, snapshot) {
              final selectedValue = _animationControllerSelected.value;
              return GestureDetector(
                onTap: () {
                  if (!_selectedMode) {
                    _animationControllerSelected.forward().whenComplete(() {
                      setState(() {
                        _selectedMode = true;
                      });
                    });
                  } else {
                    _animationControllerSelected.reverse().whenComplete(() {
                      setState(() {
                        _selectedMode = false;
                      });
                    });
                  }
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(selectedValue),
                  child: AbsorbPointer(
                    absorbing: !_selectedMode,
                    child: SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * .6,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: List.generate(
                          mockCardList.length,
                          (index) => Card3DItem(
                            animation: _animationControllerMovement,
                            height: constraints.maxHeight / 2,
                            card: mockCardList[index],
                            percent: selectedValue,
                            depth: index,
                            verticalFactor: _getCurrentFactor(index),
                            onCardSeleceted: (card) {
                              _onCardSelected(card, index);
                            },
                          ),
                        ).reversed.toList(),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

class Card3DItem extends AnimatedWidget {
  const Card3DItem({
    Key? key,
    required this.card,
    required this.percent,
    required this.height,
    required this.depth,
    required this.onCardSeleceted,
    required this.animation,
    this.verticalFactor = 0,
  }) : super(key: key, listenable: animation);

  final Card3D card;
  final double percent;
  final double height;
  final int depth;
  final ValueChanged<Card3D> onCardSeleceted;
  final int verticalFactor;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    const depthFactor = 50.0;
    final bottomMargin = height / 4.0;
    return Positioned(
      left: 0,
      right: 0,
      top: height + -depth * height / 2 * percent - bottomMargin,
      child: Opacity(
        opacity: verticalFactor == 0 ? 1 : 1 - animation.value,
        child: Hero(
          tag: card.title,
          flightShuttleBuilder: (context, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            Widget _current;
            if (flightDirection == HeroFlightDirection.push) {
              _current = toHeroContext.widget;
            } else {
              _current = fromHeroContext.widget;
            }

            return AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                final newValue = lerpDouble(0.0, 2 * pi, animation.value);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(newValue!),
                  child: _current,
                );
              },
            );
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(
                  0.0,
                  verticalFactor *
                      animation.value *
                      MediaQuery.of(context).size.height,
                  depth * depthFactor),
            child: GestureDetector(
              onTap: () {
                onCardSeleceted(card);
              },
              child: SizedBox(
                  height: height,
                  child: Card3DWidget(
                    card: card,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class CardHorizontal extends StatelessWidget {
  const CardHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Recently played",
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mockCardList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card3DWidget(card: mockCardList[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Card3DWidget extends StatelessWidget {
  const Card3DWidget({Key? key, required this.card}) : super(key: key);

  final Card3D card;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);

    return PhysicalModel(
      elevation: 10,
      borderRadius: borderRadius,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          image: card.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
