import 'package:flutter/material.dart';

import '../models/city.dart';
import 'city_card.dart';

class DesktopCityCard extends StatelessWidget {
  const DesktopCityCard({
    Key? key,
    required this.cities,
    required this.cardColors,
  }) : super(key: key);

  final Map<int, City> cities;
  final Map<int, Color?> cardColors;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CityCard(
                    image: 'assets/backcard.jpg',
                    name: cities[0]!.name,
                    km: cities[0]!.km,
                    backColor: cardColors[0]!,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CityCard(
                    image: 'assets/backcard.jpg',
                    name: cities[1]!.name,
                    km: cities[1]!.km,
                    backColor: cardColors[1]!,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CityCard(
                  image: 'assets/backcard.jpg',
                  name: cities[2]!.name,
                  km: cities[2]!.km,
                  backColor: cardColors[2]!,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CityCard(
                  image: 'assets/backcard.jpg',
                  name: cities[3]!.name,
                  km: cities[3]!.km,
                  backColor: cardColors[3]!,
                ),
              ),
            )
          ],
        ))
      ],
    );
  }
}
