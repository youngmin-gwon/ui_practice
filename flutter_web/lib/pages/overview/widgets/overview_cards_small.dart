import 'package:flutter/material.dart';
import 'package:flutter_web/pages/overview/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Rides in progress",
            value: "7",
            isActive: true,
            onTap: () {},
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Packages delivered",
            value: "17",
            onTap: () {},
            topColor: Colors.lightGreen,
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
              title: "Cancelled delivery",
              value: "3",
              onTap: () {},
              topColor: Colors.redAccent),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Scheduled deliveries",
            value: "7",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
