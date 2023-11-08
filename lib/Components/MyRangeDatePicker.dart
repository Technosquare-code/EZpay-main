import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_translator/flutter_translator.dart';

class MyRangeDatePicker extends StatefulWidget {
  @override
  _MyRangeDatePickerState createState() => _MyRangeDatePickerState();
}

class _MyRangeDatePickerState extends State<MyRangeDatePicker> {
  final TranslatorGenerator translator = TranslatorGenerator.instance;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 25,
            ),
            child: Text(
              translator.getString("RangeDatePicker.select"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 25,
                ),
                child: Text(
                  translator.getString("General.start"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: DatePickerWidget(
                  looping: true,
                  firstDate: DateTime(1000),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(3000),
                  onChange: (DateTime newDate, _) {
                    startDate = newDate;
                    if (endDate.isBefore(startDate)) {
                      showError = true;
                    } else {
                      showError = false;
                    }
                    setState(() {});
                  },
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    pickerHeight: 155,
                    itemTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                    dividerColor: Colors.grey.shade200,
                    showTitle: false,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 25,
                ),
                child: Text(
                  translator.getString("General.end"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: DatePickerWidget(
                  looping: true,
                  firstDate: DateTime(1000),
                  initialDate: endDate,
                  lastDate: DateTime(3000),
                  onChange: (DateTime newDate, _) {
                    endDate = newDate;
                    if (endDate.isBefore(startDate)) {
                      showError = true;
                    } else {
                      showError = false;
                    }
                    setState(() {});
                  },
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    pickerHeight: 155,
                    itemTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                    dividerColor: Colors.grey.shade200,
                    showTitle: false,
                  ),
                ),
              ),
            ],
          ),
          if (showError)
            Container(
              transform: Matrix4.translationValues(0, -12, 0),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                translator.getString("General.errorDatePicker"),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(
                  MediaQuery.of(context).size.width,
                  45,
                ),
              ),
              onPressed: () {
                if (endDate.isBefore(startDate)) {
                  showError = true;
                  setState(() {});
                } else {
                  Navigator.of(context).pop({
                    "start": startDate,
                    "end": endDate,
                  });
                }
              },
              child: Text(
                translator.getString("General.submit"),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
