import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:nike_shop_ui/domain/product.dart';

class CardView extends StatefulWidget {
  const CardView({
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
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  Alignment get _alignment => widget.alignment ?? FractionalOffset.center;
  Product get _product => widget.product;
  int get _index => widget.index;
  double get _page => widget.page ?? 0;
  double get _perspective => widget.perspective ?? 0.002;
  double get _angle => widget.angle ?? pi / 2;
  double get _productAngle => widget.angle ?? -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _alignment == const FractionalOffset(0.0, 0.5)
              ? Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, _perspective)
                    ..scale(1 - lerpDouble(0, -0.25, _index - _page)!)
                    ..rotateY(_angle * (_page - _index)),
                  alignment: _alignment,
                  child: CardBackground(
                    product: _product,
                  ),
                )
              : CardBackground(product: _product),
          Transform.translate(
            offset: Offset(0, -20),
            child: Transform.rotate(
              angle: _productAngle * (_page - _index),
              child: Container(
                height: 160,
                child: Center(
                  child: Transform.rotate(
                    angle: 276,
                    child: Image(image: _product.image),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardBackground extends StatelessWidget {
  const CardBackground({
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
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      product.subtitle.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            product.price.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.99,
                          child: Container(
                            height: 48,
                            width: 48,
                            color: const Color(0xFF232323),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white30,
                            ),
                          ),
                        ),
                      ],
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
}
