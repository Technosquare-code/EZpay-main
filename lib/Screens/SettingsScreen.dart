import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Screens/ChangePasswordScreen.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class SettingsScreen extends StatefulWidget {
  static const routName = "/settingsScreen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = ValueNotifier<bool>(true);
  bool _checked = false;
  final translator = TranslatorGenerator.instance;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() => _checked = _controller.value);
      if (_checked == true) {
        SharedPreferences.getInstance().then(
          (value) => value.setString("notification", "0"),
        );
      } else {
        SharedPreferences.getInstance().then(
          (value) => value.setString("notification", "1"),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          translator.getString("Setting.title"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translator.getString("Setting.changeLang"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PopupMenuButton(
                  onSelected: (v) {
                    if (v == "1") {
                      translator.translate("en", save: true);
                    } else {
                      translator.translate("es", save: true);
                    }
                  },
                  child: Text(
                    translator.currentLocale!.languageCode == "en"
                        ? "English"
                        : "Español",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: "1",
                      child: Text(
                        "English",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: "2",
                      child: Text(
                        "Español",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 0.8),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ChangePasswordScreen.routName);
              },
              child: Text(
                translator.getString("Setting.changePassword"),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 0.8),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translator.getString("Setting.notification"),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                AdvancedSwitch(
                  activeColor: MyColor.primaryColor,
                  inactiveColor: MyColor.primaryColor,
                  controller: _controller,
                  thumb: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (_, val, __) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              val == true
                                  ? Icons.circle_outlined
                                  : Icons.remove,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 0.8),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
