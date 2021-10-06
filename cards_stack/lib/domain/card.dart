import 'package:cards_stack/gen/assets.gen.dart';

class Card3D {
  final String title;
  final String author;
  final AssetGenImage image;

  const Card3D({
    required this.title,
    required this.author,
    required this.image,
  });
}

const mockCardList = [
  Card3D(
    title: "My Twisted Fantasy",
    author: "Kanye West",
    image: Assets.album1,
  ),
  Card3D(
    title: "College Dropout",
    author: "Kanye West",
    image: Assets.album2,
  ),
  Card3D(
    title: "25",
    author: "Adele",
    image: Assets.album3,
  ),
  Card3D(
    title: "Alexander Hamilton",
    author: "Lin Manual Miranda",
    image: Assets.album4,
  ),
  Card3D(
    title: "Sugar",
    author: "Maroon5",
    image: Assets.album5,
  ),
  Card3D(
    title: "Misery",
    author: "Maroon5",
    image: Assets.album6,
  ),
  Card3D(
    title: "Poker Face",
    author: "Lady Gaga",
    image: Assets.album7,
  ),
];
