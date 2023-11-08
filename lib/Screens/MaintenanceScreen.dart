import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translator/flutter_translator.dart';

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translator = TranslatorGenerator.instance;
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.primaryColor,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.primaryColor,
        ),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 1.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.15,
              height: MediaQuery.of(context).size.height / 8,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              translator.getString("Maintain.title"),
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              translator.getString("Maintain.text"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
