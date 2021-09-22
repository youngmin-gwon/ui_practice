import 'package:flutter/material.dart';

class Album {
  final String title;
  final String artist;
  final AssetImage coverImage;

  const Album({
    required this.title,
    required this.artist,
    required this.coverImage,
  });
}
