import 'package:billapp/Components/BannerLoading.dart';
import 'package:billapp/Components/CategoryLoading.dart';
import 'package:billapp/Components/HomeCategory.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Providers/HomeProvider.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/package%20edit/src/responsive_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routName = "/homeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;
  var formatter = NumberFormat('#,##0.' + "#" * 4);
  List<Map<String, dynamic>> categories = [
    {
      "image": "assets/images/home1.png",
      "title": "Domestic Mobile Recharge",
      "id": "1"
    },
    {
      "image": "assets/images/home2.png",
      "title": "Int’l Mobile Topup",
      "id": "2"
    },
    {
      "image": "assets/images/home3.png",
      "title": "Int’l Long Distance",
      "id": "3"
    },
    {"image": "assets/images/home4.png", "title": "Mobile Data", "id": "4"},
    {"image": "assets/images/home5.png", "title": "Utilities", "id": "5"},
    {"image": "assets/images/home6.png", "title": "Car Insurance", "id": "6"},
    {"image": "assets/images/home7.png", "title": "Gift cards", "id": "7"},
    {
      "image": "assets/images/home8.png",
      "title": "Phone Activation",
      "id": "8"
    },
  ];

  advertiseLaunch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sorry, can't launch this URL."),
        ),
      );
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var auth = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<HomeProvider>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: MyColor.primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5.2,
                  child: Image.asset(
                    "assets/images/logo1.png",
                    fit: BoxFit.fill,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: value.categories != null
                      ? ResponsiveGridList(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          minItemWidth: MediaQuery.of(context).size.width / 4,
                          maxItemsPerRow: 3,
                          children: List.generate(
                            value.categories!.length,
                            (i) => Container(
                              child: HomeCategory(
                                image:
                                    value.categories![i].categoryIcon.toString(),
                                title:
                                    value.categories![i].categoryName.toString(),
                                id: value.categories![i].id.toString(),
                              ),
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: value.getCategories(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CategoryLoading();
                            } else {
                              return NetWorkError();
                            }
                          },
                        ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: value.categories != null
                      ? value.banners != null
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 15,
                                children: List.generate(
                                  value.banners!.length,
                                  (index) => InkWell(
                                    onTap: () {

                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                        ),
                                        child: FadeInImage(
                                          fit: BoxFit.fill,
                                          placeholder: const AssetImage(
                                              "assets/images/placeholder.png"),
                                          image: NetworkImage(
                                              "$bannerImgUrl${value.banners![index].bannerImage}"),
                                          imageErrorBuilder: (ctx, obj, st) =>
                                              Image.asset(
                                            "assets/images/placeholder.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : FutureBuilder(
                              future: value.getBanners(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return BannerLoading();
                                } else {
                                  return NetWorkError();
                                }
                              },
                            )
                      : BannerLoading(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        }),
      ),
    );
  }
}
