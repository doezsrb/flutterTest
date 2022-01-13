import 'package:flutter/material.dart';
import 'pages/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  Home.routeName: (BuildContext context) => const Home(),
};
