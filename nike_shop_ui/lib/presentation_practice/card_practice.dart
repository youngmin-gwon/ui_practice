import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:nike_shop_ui/domain/product.dart';

class CardPractice extends StatefulWidget {
  const CardPractice({
    Key? key,
    required this.product,
    required this.index,
    required this.page,
    this.perspective,
    this.angle,
    this.productAngle,
    this.alignment,
  }) : super(key: key);

  final Product product;
  final int index;
  final double? page;

  final double? perspective;
  final double? angle;
  final double? productAngle;
  final Alignment? alignment;

  @override
  _CardPracticeState createState() => _CardPracticeState();
}

class _CardPracticeState extends State<CardPractice> {
  Product get _product => widget.product;
  int get _index => widget.index;
  double get _page => widget.page ?? 0;

  double get _perspective => widget.perspective ?? 0.002;
  double get _angle => widget.angle ?? pi / 2;
  double get _productAngle => widget.productAngle ?? -1;
  Alignment get _alignment => widget.alignment ?? FractionalOffset.center;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      _alignment == const FractionalOffset(0.0, 0.5)
          ? Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..scale(1 - lerpDouble(0, -0.25, _index - _page)!)
                ..rotateY(_angle * (_page - _index)),
              alignment: _alignment,
              child: CardPracticeBackground(product: _product),
            )
          : Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..scale(1 - lerpDouble(0, -0.25, _index - _page)!)
                ..rotateY(_angle * (_page - _index)),
              alignment: _alignment,
              child: CardPracticeBackground(product: _product),
            ),
      Transform.translate(
        offset: const Offset(0, -20),
        child: Transform.rotate(
          angle: _productAngle * (_page - _index),
          child: SizedBox(
            height: 160,
            child: Center(
              child: Transform.rotate(
                angle: 276,
                child: Image(
                  image: _product.image,
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

class CardPracticeBackground extends StatelessWidget {
  const CardPracticeBackground({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 250,
      margin: const EdgeInsets.all(32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Container(
              height: 500,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  product.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 48,
                color: Colors.black,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      product.price.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.99,
                    child: Container(
                      width: 48,
                      height: 48,
                      color: const Color(0xFF232323),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white30,
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
