import 'package:flutter/material.dart';
import '../responsive.dart';

class CityCard extends StatelessWidget {
  const CityCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.km,
      required this.backColor})
      : super(key: key);
  final String image;
  final String name;
  final String km;
  final Color backColor;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 340,
      height: 440,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.cover)),
          )),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: backColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.isDesktop(context) ? 35 : 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('$km kilometers away',
                      style: const TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
