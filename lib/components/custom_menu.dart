import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controller.dart';
import '../responsive.dart';
import 'buttons/custom_button_menu.dart';
import 'buttons/custom_top_button.dart';

class CustomMenu {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}
  PreferredSize getMenu(
      int selectedBtn,
      Function(int) selectButton,
      VoidCallback resetMenu,
      bool expandMenu,
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2,
      bool startedAnim,
      Animation<Color?> animationBackgroundColor1,
      Animation<Color?> animationBackgroundColor2,
      double notExpandedHeight,
      double expandedHeight,
      VoidCallback menuAnimation) {
    Controller controllerGx = Get.find();
    Color? getBackgroundColor() {
      return expandMenu
          ? startedAnim
              ? animationBackgroundColor2.value
              : Colors.black
          : animationBackgroundColor1.value;
    }

    Color? getIconColors() {
      return expandMenu
          ? startedAnim
              ? animationBackgroundColor1.value
              : Colors.white
          : animationBackgroundColor2.value;
    }

    void refreshHeights() {
      expandedHeight = Responsive.isDesktop(context) ? 170 : 190;
      notExpandedHeight = Responsive.isDesktop(context) ? 100 : 120;
    }

    bool customButtonCondition() {
      return (((animation1.value == 170 || animation1.value == 190) &&
                  expandMenu) ||
              !startedAnim) &&
          !Responsive.isMobile(context);
    }

    refreshHeights();
    return PreferredSize(
        preferredSize: expandMenu
            ? Size.fromHeight(startedAnim ? animation1.value : expandedHeight)
            : Size.fromHeight(
                startedAnim ? animation2.value : notExpandedHeight),
        child: Obx(() => Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              decoration: BoxDecoration(color: getBackgroundColor()),
              child: Stack(
                children: <Widget>[
                  if (!Responsive.isMobile(context))
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      color: getBackgroundColor(),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.isDesktop(context) ? 0 : 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <CustomTopButton>[
                            CustomTopButton(text: 'Places to stay'),
                            CustomTopButton(text: 'Experiences'),
                            CustomTopButton(text: 'Online Experiences'),
                          ],
                        ),
                      ),
                    ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: Responsive.isMobile(context)
                        ? Alignment.topCenter
                        : expandMenu
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                    child: AnimatedContainer(
                      onEnd: () {},
                      duration: const Duration(milliseconds: 200),
                      height: 70,
                      width: expandMenu ? 1000 : 350,
                      decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(color: Colors.grey, blurRadius: 7)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.grey[200]!)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (customButtonCondition())
                            Expanded(
                              child: CustomButtonMenu(
                                resetMenu: resetMenu,
                                onSelectedDate: _onSelectionChanged,
                                selectBtn: selectButton,
                                currentBtn: selectedBtn,
                                id: 1,
                              ),
                            ),
                          if (customButtonCondition())
                            Expanded(
                              child: CustomButtonMenu(
                                resetMenu: resetMenu,
                                onSelectedDate: _onSelectionChanged,
                                selectBtn: selectButton,
                                currentBtn: selectedBtn,
                                id: 2,
                              ),
                            ),
                          if (customButtonCondition())
                            Expanded(
                              child: CustomButtonMenu(
                                resetMenu: resetMenu,
                                onSelectedDate: _onSelectionChanged,
                                selectBtn: selectButton,
                                currentBtn: selectedBtn,
                                id: 3,
                              ),
                            ),
                          Expanded(
                            child: CustomButtonMenu(
                              resetMenu: resetMenu,
                              onSelectedDate: _onSelectionChanged,
                              selectBtn: selectButton,
                              currentBtn: selectedBtn,
                              id: 4,
                              expandMenu: expandMenu,
                              menuAnimation: menuAnimation,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: SvgPicture.asset(
                          'assets/train.svg',
                          color: getIconColors(),
                        ),
                      ),
                    ),
                  if (!Responsive.isMobile(context))
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, right: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                'Become a Host',
                                style: TextStyle(color: getIconColors()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.circle,
                                color: getIconColors(),
                              ),
                            ),
                            if (controllerGx.loginUser.value)
                              PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) {
                                  return List<PopupMenuEntry<int>>.generate(
                                      1,
                                      (int index) => const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('Logout'),
                                          ));
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onSelected: (int value) async {
                                  if (value == 1) {
                                    await controllerGx.removeUser();
                                    Get.offAll<Login>(const Login());
                                  }
                                },
                              ),
                            if (controllerGx.loginUser.value == false)
                              PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) {
                                  return List<PopupMenuEntry<int>>.generate(
                                      1,
                                      (int index) => const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('Login'),
                                          ));
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onSelected: (int value) {
                                  if (value == 1) {
                                    Get.to<Login>(const Login());
                                  }
                                },
                              )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            )));
  }
}
