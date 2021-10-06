import 'package:cards_stack/presentation/card_home_page.dart';
import 'package:flutter/material.dart';

import 'package:cards_stack/domain/card.dart';
import 'package:flutter/widgets.dart';

class CardsDetails extends StatelessWidget {
  const CardsDetails({
    Key? key,
    required this.card,
  }) : super(key: key);

  final Card3D card;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Align(
            child: SizedBox(
              width: 200,
              child: Hero(
                tag: card.title,
                child: Card3DWidget(
                  card: card,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            card.title,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            card.author,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
