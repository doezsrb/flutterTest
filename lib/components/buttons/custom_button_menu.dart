import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomButtonMenu extends StatelessWidget {
  const CustomButtonMenu(
      {Key? key,
      required this.selectBtn,
      required this.currentBtn,
      required this.id,
      required this.onSelectedDate,
      required this.resetMenu,
      this.expandMenu,
      this.menuAnimation})
      : super(key: key);
  final Function(int) selectBtn;
  final int currentBtn;
  final int id;
  final Function resetMenu;
  final Function(DateRangePickerSelectionChangedArgs) onSelectedDate;
  final bool? expandMenu;
  final VoidCallback? menuAnimation;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (expandMenu != null && expandMenu == false) {
            menuAnimation!();
          } else {
            selectBtn(id);
          }
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              id == 2 || id == 3 ? const Size(170, 90) : const Size(265, 90)),
          shadowColor: MaterialStateProperty.all(Colors.black),
          elevation:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (currentBtn == id) {
              return 10;
            } else {
              return 0;
            }
          }),
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.grey[200];
            } else {
              if (currentBtn == id) {
                return Colors.white;
              } else {
                return Colors.transparent;
              }
            }
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (expandMenu != null && expandMenu != true)
                      const Text('Search',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                    if (expandMenu == null || expandMenu == true)
                      const Text('Location',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                    if (expandMenu == null || expandMenu == true)
                      const Text('Where are you going?',
                          style: TextStyle(color: Colors.black, fontSize: 12))
                  ],
                ),
              ),
              if (id == 4)
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: 50, minWidth: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          if (currentBtn == id)
                            const Text('Search',
                                style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
