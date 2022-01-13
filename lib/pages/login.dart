import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:get/get.dart';

import '../components/custom_menu.dart';
import '../components/login_form.dart';
import '../controller.dart';
import '../responsive.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  Controller controllerGx = Get.find();
  int selectedBtn = 0;
  bool expandMenu = true;
  bool startedAnim = false;

  // ignore: unused_field
  final String _selectedDate = '';
  // ignore: unused_field
  final String _dateCount = '';
  // ignore: unused_field
  final String _range = '';
  // ignore: unused_field
  final String _rangeCount = '';

  bool loading = true;
  AnimationController? controller;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<Color?> animationBackgroundColor1;
  late Animation<Color?> animationBackgroundColor2;
  late Tween<double>? _tween1;
  late Tween<double>? _tween2;
  late double expandedHeight;
  late double notExpandedHeight;

  @override
  void initState() {
    Future<dynamic>.delayed(Duration.zero).then((dynamic value) {
      expandedHeight = Responsive.isDesktop(context) ? 170 : 190;
      notExpandedHeight = Responsive.isDesktop(context) ? 100 : 120;
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
      _tween1 = Tween<double>(begin: notExpandedHeight, end: expandedHeight);
      animation1 = _tween1!.animate(controller!)
        ..addListener(() {
          setState(() {
            startedAnim = true;
          });
        });
      _tween2 = Tween<double>(begin: expandedHeight, end: notExpandedHeight);
      animation2 = _tween2!.animate(controller!);
      animationBackgroundColor1 =
          ColorTween(begin: Colors.black, end: Colors.white)
              .animate(controller!);
      animationBackgroundColor2 =
          ColorTween(begin: Colors.white, end: Colors.black)
              .animate(controller!);
    }).then((void value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !loading
          ? CustomMenu().getMenu(
              selectedBtn,
              (int p0) => null,
              () {},
              expandMenu,
              context,
              animation1,
              animation2,
              startedAnim,
              animationBackgroundColor1,
              animationBackgroundColor2,
              notExpandedHeight,
              expandedHeight,
              () {})
          : null,
      body: Obx(() => Stack(
            children: <Widget>[
              Align(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 200),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        )
                      ]),
                  child: Container(
                    color: Colors.white,
                    height: 230,
                    width: 400,
                    child: LoginForm(
                      login: (String username, String password) async {
                        final bool result =
                            await controllerGx.login(username, password);
                        if (!result) {
                          showDialog<AlertDialog>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Try again'),
                                    content: const Text('Login failed'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  ));
                        } else {
                          const String testToken = 'testtoken000';
                          final User user = User(
                              id: 1,
                              username: username,
                              password: password,
                              token: testToken);
                          await controllerGx.saveUser(user);

                          Get.offAll<Home>(const Home());
                        }
                        //controller.login
                      },
                    ),
                  ),
                ),
              ),
              if (controllerGx.loading.value)
                const Align(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Text(
                      'Loading',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          )),
    );
  }
}
