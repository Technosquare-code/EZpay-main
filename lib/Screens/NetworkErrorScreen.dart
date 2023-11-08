import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';

class NetworkErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translator = TranslatorGenerator.instance;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/notLoading(128).png"),
            Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                translator.getString("Network.textError"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
