import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:flutter_application_1/pages/home.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'models/user.dart';
import 'pages/login.dart';
import 'routes.dart';

void main() {
  Controller controllerGx = Get.put(Controller());
  runApp(GetMaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'Test App',
      home: FutureBuilder<User?>(
        future: controllerGx.getUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          final User? data = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
          }
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else if (data == null)
            return const Login();
          else
            return const Home();
        },
      ),
      theme: ThemeData.light(),
      routes: routes));
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
