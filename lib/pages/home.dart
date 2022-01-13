import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../components/custom_menu.dart';
import '../components/desktop_city_card.dart';
import '../components/discover_card.dart';
import '../components/footer.dart';
import '../components/gateways_list.dart';
import '../components/mobile_city_card.dart';
import '../components/popup_date.dart';

import '../models/city.dart';
import '../responsive.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String routeName = 'home';
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int selectedBtn = 0;
  bool expandMenu = true;
  bool startedAnim = false;
  // ignore: unused_field
  String _selectedDate = '';
  // ignore: unused_field
  String _dateCount = '';
  // ignore: unused_field
  String _range = '';
  // ignore: unused_field
  String _rangeCount = '';
  final Map<int, City> cities = City.fakeData().asMap();

  final Map<int, Color?> cardColors = <int, Color?>{
    0: Colors.red[900],
    1: Colors.pink[900],
    2: Colors.purple[900],
    3: Colors.teal[900]
  };
  bool loading = true;
  AnimationController? controller;
  Animation<double>? animation1;
  Animation<double>? animation2;
  Animation<Color?>? animationBackgroundColor1;
  Animation<Color?>? animationBackgroundColor2;
  late Tween<double>? _tween1;
  late Tween<double>? _tween2;
  double? expandedHeight;
  double? notExpandedHeight;
  PageController? pageController;
  GlobalKey screenKey = GlobalKey();
  double? whiteBackgroundSizeHeight;
  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.7);
    Future<dynamic>.delayed(Duration.zero).then((dynamic value) {
      final RenderBox box =
          screenKey.currentContext!.findRenderObject() as RenderBox;
      whiteBackgroundSizeHeight = box.size.height;
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

  void menuAnimation() {
    refreshAnimations();
    controller!.forward(from: 0.0);
    setState(() {
      expandMenu = !expandMenu;
    });
  }

  void resetMenu() {
    setState(() {
      selectedBtn = 0;
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        // ignore: avoid_dynamic_calls
        final DateTime? startDate = args.value.startDate as DateTime?;
        // ignore: avoid_dynamic_calls
        final DateTime? endDate = args.value.endDate as DateTime?;
        _range =
            '${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate ?? startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        // ignore: avoid_dynamic_calls
        _dateCount = args.value.length.toString();
      } else {
        // ignore: avoid_dynamic_calls
        _rangeCount = args.value.length.toString();
      }
    });
  }

  void refreshAnimations() {
    expandedHeight = Responsive.isDesktop(context) ? 170 : 190;
    notExpandedHeight = Responsive.isDesktop(context) ? 100 : 120;
    _tween1!.begin = notExpandedHeight;
    _tween1!.end = expandedHeight;
    _tween2!.begin = expandedHeight;
    _tween2!.end = notExpandedHeight;
  }

  void selectButton(int id) {
    setState(() {
      selectedBtn = id;
    });
  }

  void _onStartScroll(ScrollMetrics metrics) {}

  void _onUpdateScroll(ScrollMetrics metrics) {
    if (metrics.pixels == 100) {
      menuAnimation();
    }
    if (metrics.pixels > 100) {
      if (expandMenu) {
        menuAnimation();
      }
    }
    if (metrics.pixels == 0) {
      if (!expandMenu) {
        menuAnimation();
      }
    }
  }

  void _onEndScroll(ScrollMetrics metrics) {}

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      refreshAnimations();
    }

    return Scaffold(
        appBar: !loading
            ? CustomMenu().getMenu(
                selectedBtn,
                selectButton,
                resetMenu,
                expandMenu,
                context,
                animation1!,
                animation2!,
                startedAnim,
                animationBackgroundColor1!,
                animationBackgroundColor2!,
                notExpandedHeight!,
                expandedHeight!,
                menuAnimation)
            : null,
        body: Stack(
          key: screenKey,
          children: <Widget>[
            Positioned(
                child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  _onStartScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollUpdateNotification) {
                  _onUpdateScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/background1.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Not sure where to go? Perfect.',
                                      textAlign: TextAlign.center,
                                      style: Responsive.isMobile(context)
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(color: Colors.white)
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 20, 50, 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: InkWell(
                                          onTap: () {},
                                          child: const Text(
                                            "I'm flexible",
                                            style: TextStyle(
                                                color: Colors.pink,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 200,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.black,
                    ),
                    Container(
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: whiteBackgroundSizeHeight != null
                                ? whiteBackgroundSizeHeight! / 2
                                : 0,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50, left: 50),
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          Colors.grey[400]!,
                                          Colors.white
                                        ]),
                                  ),
                                  child: Flex(
                                    direction: Responsive.isMobile(context)
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Spacer(),
                                      SizedBox(
                                        height: Responsive.isMobile(context)
                                            ? 300
                                            : double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Text(
                                              'Introducing',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            Text(
                                              'Airbnb\n gift cards',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 100
                                                          : Responsive.isTablet(
                                                                  context)
                                                              ? 80
                                                              : 50),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[800],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: const Text(
                                                  'Shop now',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      SizedBox(
                                        height: Responsive.isMobile(context)
                                            ? 300
                                            : double.infinity,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                            'assets/cards.png',
                                          ))),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Inspiration for your next trip',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 34, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: SizedBox(
                          height: 500,
                          child: Responsive(
                              mobile: MobileCityCard(
                                  pageController: pageController!,
                                  cities: cities,
                                  cardColors: cardColors),
                              tablet: DesktopCityCard(
                                  cities: cities, cardColors: cardColors),
                              desktop: DesktopCityCard(
                                  cities: cities, cardColors: cardColors))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Discover Airbnb Experiences',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 34, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: SizedBox(
                        width: double.infinity,
                        height: 600,
                        child: Flex(
                          direction: Responsive.isMobile(context)
                              ? Axis.vertical
                              : Axis.horizontal,
                          children: const <Widget>[
                            Expanded(
                              child: DiscoverCard(
                                backImg: 'assets/nature1.jpg',
                                titleText: 'Things to\ndo on your trip',
                                btnText: 'Experiences',
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                            ),
                            Expanded(
                              child: DiscoverCard(
                                backImg: 'assets/nature2.jpeg',
                                titleText: 'Things to do\nfrom home',
                                btnText: 'Online Experiences',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Container(
                        width: double.infinity,
                        height: 700,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/nature3.jpg'),
                              fit: BoxFit.cover),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(children: <Widget>[
                          Positioned(
                            top: 60,
                            left: Responsive.isMobile(context) ? 20 : 60,
                            child: Text(
                              'Questions \nabout\nhosting?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Responsive.isMobile(context) ? 50 : 100,
                                  shadows: const <Shadow>[
                                    Shadow(blurRadius: 10)
                                  ]),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            left: Responsive.isMobile(context) ? 20 : 60,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: const Padding(
                                padding: EdgeInsets.all(17),
                                child: Text(
                                  'Ask a Superhost',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Inspiration for future getaways',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: GetawaysWidget(),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                      height: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Footer(),
                    )
                  ],
                ),
              ),
            )),
            if (selectedBtn != 0)
              Align(
                alignment: Alignment.topCenter,
                child: PopupDate(
                    resetMenu: resetMenu,
                    onSelectionChanged: _onSelectionChanged),
              ),
          ],
        ));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
