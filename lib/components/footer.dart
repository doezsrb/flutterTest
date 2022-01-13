import 'package:flutter/material.dart';

import '../responsive.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: Responsive.isMobile(context)
            ? EdgeInsets.zero
            : const EdgeInsets.all(15),
        child: Flex(
          direction:
              Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flex(
              direction: Responsive.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('© 2021 Airbnb, Inc.·',
                    style: TextStyle(color: Colors.black)),
                TextButton(
                    onPressed: () {},
                    child: const Text('Privacy ·',
                        style: TextStyle(color: Colors.black))),
                TextButton(
                    onPressed: () {},
                    child: const Text('Terms ·',
                        style: TextStyle(color: Colors.black))),
                TextButton(
                    onPressed: () {},
                    child: const Text('Sitemap',
                        style: TextStyle(color: Colors.black))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {},
                    child: Row(children: const <Widget>[
                      Icon(Icons.language),
                      Text('English(US)')
                    ])),
                TextButton(
                    onPressed: () {},
                    child: Row(children: const <Widget>[
                      Icon(Icons.euro),
                      Text('EUR')
                    ])),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.facebook, color: Colors.black),
                const SizedBox(width: 10),
                const Icon(Icons.mail, color: Colors.black),
                const SizedBox(width: 10),
                const Icon(Icons.youtube_searched_for, color: Colors.black)
              ],
            )
          ],
        ),
      ),
    );
  }
}
