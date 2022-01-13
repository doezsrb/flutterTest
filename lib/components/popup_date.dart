import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PopupDate extends StatelessWidget {
  const PopupDate(
      {Key? key, required this.resetMenu, required this.onSelectionChanged})
      : super(key: key);
  final VoidCallback resetMenu;
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      height: 400,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            SfDateRangePicker(
              onSelectionChanged: onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              enableMultiView: true,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3))),
            ),
            TextButton(
              onPressed: () {},
              child: GestureDetector(
                onTap: () {
                  resetMenu();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Close'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
