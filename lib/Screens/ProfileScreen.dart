import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Screens/ChangePasswordScreen.dart';
import 'package:billapp/Screens/EditProfileScreen.dart';
import 'package:billapp/Screens/InfoScreen.dart';
import 'package:billapp/Screens/LoginScreen.dart';
import 'package:billapp/Screens/NotificationScreen.dart';
import 'package:billapp/Screens/SubAgentScreen.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routName = "/profileScreen";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final translator = TranslatorGenerator.instance;
  bool showButtons = false;

  logout() {
    Utils().showDeleteDialog(
      context,
      translator.getString("Profile.logoutQuestion"),
      () {
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
      },
    );
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
        title: Text(
          translator.getString("Profile.title"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1.15,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: MyColor.primaryColor,
                padding: const EdgeInsets.all(15),
                child: Consumer<AuthProvider>(builder: (context, value, child) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: value.currentUser!.profilePicture == ""
                            ? const AssetImage("assets/images/profile.jpg")
                            : NetworkImage(
                                    "$profileImgUrl${value.currentUser!.profilePicture}")
                                as ImageProvider<Object>,
                      ),
                      const SizedBox(width: 25),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${value.currentUser!.name}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${translator.getString("Profile.email")}: ${value.currentUser!.email}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${translator.getString("Profile.mobile")}: ${value.currentUser!.mobile}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${translator.getString("Profile.wallet")}: \$${value.currentUser!.wallet}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 10),
              Options(
                icon: Icons.notifications,
                title: translator.getString("Profile.norification"),
                onTap: () {
                  Navigator.of(context).pushNamed(NotificationScreen.routName);
                },
              ),
              Options(
                icon: Icons.person,
                title: translator.getString("Profile.editProfile"),
                onTap: () {
                  Navigator.of(context).pushNamed(EditProfileScreen.routName);
                },
              ),
              Options(
                icon: Icons.person_pin,
                title: translator.getString("Profile.subAgent"),
                onTap: () {
                  Navigator.of(context).pushNamed(SubAgentScreen.routName);
                },
              ),
              Options(
                icon: Icons.lock,
                title: translator.getString("Setting.changePassword"),
                onTap: () => Navigator.of(context).pushNamed(
                  ChangePasswordScreen.routName,
                ),
              ),
              Options(
                icon: Icons.logout,
                title: translator.getString("Profile.logout"),
                onTap: logout,
              ),
              const Divider(thickness: 0.8),
              SecondOptions(
                title: translator.getString("Profile.about"),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(InfoScreen.routName, arguments: {
                    "title": "About Us",
                    "info": "about",
                  });
                },
              ),
              SecondOptions(
                title: translator.getString("Profile.policy"),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(InfoScreen.routName, arguments: {
                    "title": "Privacy Policy",
                    "info": "privacy",
                  });
                },
              ),
              SecondOptions(
                title: translator.getString("Profile.terms"),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(InfoScreen.routName, arguments: {
                    "title": "Terms and Conditions",
                    "info": "terms",
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showButtons == true)
              InkWell(
                onTap: () {
                  translator.translate("en", save: true);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage("assets/images/USA.jpg"),
                ),
              ),
            if (showButtons == true) const SizedBox(height: 8),
            if (showButtons == true)
              InkWell(
                onTap: () {
                  translator.translate("es", save: true);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage("assets/images/Spain.png"),
                ),
              ),
            if (showButtons == true) const SizedBox(height: 8),
            InkWell(
              onTap: () => setState(() => showButtons = !showButtons),
              child: const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function()? onTap;

  const Options({this.icon, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      minLeadingWidth: icon != null ? 20 : 2,
      leading: icon != null ? Icon(icon, color: Colors.grey) : const SizedBox(),
      title: Text(
        title.toString(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: "Gilroy",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SecondOptions extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const SecondOptions({required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.white,
        child: Text(
          title.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
