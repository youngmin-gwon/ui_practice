import 'package:flutter/material.dart';
import 'package:nike_size_selection_ui/core/presentation/assets/assets.gen.dart';

class ProductShowcase extends StatelessWidget {
  const ProductShowcase({
    Key? key,
    required this.productSize,
  }) : super(key: key);

  final double productSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: productSize * 10,
      width: productSize * 10,
      curve: Curves.fastLinearToSlowEaseIn,
      child: const Image(
        image: Assets.nikeFront,
      ),
    );
  }
}
