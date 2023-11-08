import 'package:billapp/Components/Empty.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/NotificationComponent.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const routName = "/notificationScreen";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final translator = TranslatorGenerator.instance;

  @override
  void deactivate() {
    Provider.of<NotificationProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          translator.getString("Notification.title"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Consumer<NotificationProvider>(
          builder: (context, value, child) => value.notifications != null
              ? value.notifications!.isEmpty
                  ? Empty()
                  : Column(
                      children: value.notifications!.map((notification) {
                        return NotificationComponent(notification);
                      }).toList(),
                    )
              : FutureBuilder(
                  future: value.getNotification(
                    auth.currentUser!.id.toString(),
                  ),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MyLoading();
                    } else {
                      return NetWorkError();
                    }
                  },
                ),
        ),
      ),
    );
  }
}
