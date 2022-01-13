import 'package:flutter/material.dart';

class InspirationButton extends StatelessWidget {
  const InspirationButton(
      {Key? key,
      required this.id,
      required this.currentSelected,
      required this.parentFunc})
      : super(key: key);
  final int id;
  final int currentSelected;
  final Function(int) parentFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border(
                bottom: currentSelected == id
                    ? const BorderSide(color: Colors.white)
                    : const BorderSide(color: Colors.transparent))),
        child: TextButton(
          onPressed: () {
            parentFunc(id);
          },
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.white.withOpacity(0.04);
                }
              })),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Test test test',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
