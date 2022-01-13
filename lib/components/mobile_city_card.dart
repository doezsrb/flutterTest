import 'package:flutter/material.dart';

import '../models/city.dart';
import 'city_card.dart';

class MobileCityCard extends StatelessWidget {
  const MobileCityCard({
    Key? key,
    required this.pageController,
    required this.cities,
    required this.cardColors,
  }) : super(key: key);

  final PageController pageController;
  final Map<int, City> cities;
  final Map<int, Color?> cardColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          return true;
        },
        child: PageView(
          controller: pageController,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CityCard(
                image: 'assets/backcard.jpg',
                name: cities[0]!.name,
                km: cities[0]!.km,
                backColor: cardColors[0]!,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CityCard(
                image: 'assets/backcard.jpg',
                name: cities[1]!.name,
                km: cities[1]!.km,
                backColor: cardColors[1]!,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CityCard(
                image: 'assets/backcard.jpg',
                name: cities[2]!.name,
                km: cities[2]!.km,
                backColor: cardColors[2]!,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CityCard(
                image: 'assets/backcard.jpg',
                name: cities[3]!.name,
                km: cities[3]!.km,
                backColor: cardColors[3]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
