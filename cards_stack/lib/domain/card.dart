import 'package:cards_stack/gen/assets.gen.dart';

class Card {
  final String title;
  final String author;
  final AssetGenImage image;

  const Card({
    required this.title,
    required this.author,
    required this.image,
  });
}

const mockCardList = [
  Card(
    title: "My Twisted Fantasy",
    author: "Kanye West",
    image: Assets.album1,
  ),
  Card(
    title: "College Dropout",
    author: "Kanye West",
    image: Assets.album2,
  ),
  Card(
    title: "25",
    author: "Adele",
    image: Assets.album3,
  ),
  Card(
    title: "Alexander Hamilton",
    author: "Lin Manual Miranda",
    image: Assets.album4,
  ),
  Card(
    title: "Sugar",
    author: "Maroon5",
    image: Assets.album5,
  ),
  Card(
    title: "Misery",
    author: "Maroon5",
    image: Assets.album6,
  ),
  Card(
    title: "Poker Face",
    author: "Lady Gaga",
    image: Assets.album7,
  ),
];
