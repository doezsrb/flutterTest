import 'package:flutter/material.dart';

class CustomTopButton extends StatelessWidget {
  const CustomTopButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Material(
        color: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
          color: Colors.white.withOpacity(0.3),
        )),
        child: InkWell(
          onTap: () {},
          child: Text(
            text,
            style: const TextStyle(fontSize: 19, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
