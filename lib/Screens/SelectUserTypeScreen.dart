import 'package:billapp/Screens/LoginScreen.dart';
import 'package:billapp/Screens/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserTypeScreen extends StatelessWidget {
  static const routName = "/selectUserTypeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              SharedPreferences.getInstance().then((value) {
                value.setString("type", "agent");
              });
              Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    "assets/images/agent.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "AGENT",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Divider(color: Colors.black),
          const SizedBox(height: 50),
          InkWell(
            onTap: () {
              SharedPreferences.getInstance().then((value) {
                value.setString("type", "user");
              });
              Navigator.of(context).pushReplacementNamed(
                UserHomeScreen.routName,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "USER",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
