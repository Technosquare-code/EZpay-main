import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Screens/HomeScreen.dart';
import 'package:billapp/Screens/ProfileScreen.dart';
import 'package:billapp/Screens/TransactionScreen.dart';
import 'package:billapp/Utils/FirebaseNotificatonServices.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routName = "/dashboardScreen";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 1;
  final List _pages = [
    TransactionScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {},
          )
        ],
      ),
    );
  }

  updateFcmkToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateAgentFcmToken(token.toString());
    }
  }

  @override
  void initState() {
    FirebaseNotification().setUpFirebase(onDidReceiveLocalNotification);
    updateFcmkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: index == 0 ? MyColor.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: index == 0 ? Colors.white : Colors.black45,
                    size: 30,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: index == 1 ? MyColor.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.home_outlined,
                    color: index == 1 ? Colors.white : Colors.black45,
                    size: 30,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: index == 2 ? MyColor.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: index == 2 ? Colors.white : Colors.black45,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
