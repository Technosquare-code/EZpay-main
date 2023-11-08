import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_translator/flutter_translator.dart';

class MyDatePicker extends StatefulWidget {
  final DateTime? firstDate;
  final DateTime? endDate;

  const MyDatePicker({this.firstDate, this.endDate});
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  final TranslatorGenerator translator = TranslatorGenerator.instance;
  DateTime selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
              translator.getString("General.selectDate"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DatePickerWidget(
            looping: true,
            firstDate: widget.firstDate ?? DateTime(1000),
            initialDate: DateTime.now(),
            lastDate: widget.endDate ?? DateTime(3000),
            onChange: (DateTime newDate, _) {
              selectDate = newDate;
              setState(() {});
            },
            pickerTheme: DateTimePickerTheme(
              backgroundColor: Colors.transparent,
              pickerHeight: 150,
              itemTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
              dividerColor: Colors.grey.shade200,
              showTitle: false,
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
                Navigator.of(context).pop(selectDate);
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
