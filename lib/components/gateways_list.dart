import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dest.dart';
import '../responsive.dart';
import 'buttons/inspiration_button.dart';

class GetawaysWidget extends StatefulWidget {
  const GetawaysWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GetawaysWidget> createState() => _GetawaysWidgetState();
}

class _GetawaysWidgetState extends State<GetawaysWidget> {
  int selectedBtn = 1;
  final int itemWidth = 100;
  final int itemHeight = 20;
  final Map<int, Dest> destionations = Dest.getFakeData().asMap();
  void selectButton(int id) {
    setState(() {
      selectedBtn = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotifination) {
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  InspirationButton(
                      id: 1,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                  InspirationButton(
                      id: 2,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                  InspirationButton(
                      id: 3,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                  InspirationButton(
                      id: 4,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                  InspirationButton(
                      id: 5,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                  InspirationButton(
                      id: 6,
                      currentSelected: selectedBtn,
                      parentFunc: selectButton),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.1),
            height: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: Responsive.isDesktop(context) ? 200 : 500,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 4 : 1,
                  crossAxisSpacing: 5,
                  childAspectRatio: itemWidth / itemHeight),
              itemBuilder: (BuildContext context, int index) => Padding(
                  padding: Responsive.isMobile(context)
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        destionations[index]!.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        destionations[index]!.subtitle,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  )),
              itemCount: destionations.length,
            ),
          )
        ],
      ),
    );
  }
}
