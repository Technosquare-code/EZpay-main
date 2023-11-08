import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';

class NetWorkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translator = TranslatorGenerator.instance;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset(
              "assets/images/notLoading(128).png",
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              translator.getString("General.networkError"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
