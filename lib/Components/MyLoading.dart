import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 1.3,
        child: SpinKitPouringHourGlassRefined(
          color: MyColor.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}
