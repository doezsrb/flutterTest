import 'package:flutter/material.dart';
import '../responsive.dart';

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key? key,
    required this.backImg,
    required this.titleText,
    required this.btnText,
  }) : super(key: key);
  final String backImg;
  final String titleText;
  final String btnText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              backImg,
            ),
            fit: BoxFit.cover),
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: Responsive.isMobile(context) ? 20 : 50,
            top: 70,
            child: Text(titleText,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.isDesktop(context) ? 60 : 40,
                    shadows: const <Shadow>[Shadow(blurRadius: 10)])),
          ),
          Positioned(
            left: Responsive.isMobile(context) ? 20 : 50,
            top: Responsive.isMobile(context) ? 180 : 230,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Text(
                  btnText,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
