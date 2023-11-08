import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        margin: const EdgeInsets.only(
          right: 20,
        ),
        child: Image.asset("assets/images/notFound.jpg"),
      ),
    );
  }
}
