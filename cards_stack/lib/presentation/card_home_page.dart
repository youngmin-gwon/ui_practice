import 'package:cards_stack/domain/card.dart';
import 'package:flutter/material.dart';

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
              onPressed: () => null,
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Placeholder(),
            ),
            Expanded(
              flex: 2,
              child: CardHorizontal(),
            ),
          ],
        ));
  }
}

class CardHorizontal extends StatelessWidget {
  const CardHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text("Recently played"),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mockCardList.length,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

class Card3DWidget extends StatelessWidget {
  const Card3DWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
