import 'package:flutter/material.dart';

class Product {
  final String title;
  final String subtitle;
  final String price;
  final String category;
  final AssetImage image;

  const Product({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.category,
    required this.image,
  });
}
