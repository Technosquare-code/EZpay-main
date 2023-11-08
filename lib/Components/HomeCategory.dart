import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Screens/CarInsuranceScreen.dart';
import 'package:billapp/Screens/ComCastScreen.dart';
import 'package:billapp/Screens/DomesticMobileRecharge.dart';
import 'package:billapp/Screens/GiftCardTopupScreen.dart';
import 'package:billapp/Screens/IntlLongDistanceScreen.dart';
import 'package:billapp/Screens/IntlMobileTopUpScreen.dart';
import 'package:billapp/Screens/MobileDataScreen.dart';
import 'package:billapp/Screens/NewActivationScreen.dart';
import 'package:billapp/Screens/PortInScreen.dart';
import 'package:billapp/Screens/PrepaidXfinityScreen.dart';
import 'package:billapp/Screens/SewerageScreen.dart';
import 'package:billapp/Screens/UtitlitiesScreen.dart';
import 'package:billapp/Screens/VehicleTaxScreen.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  final String image;
  final String title;
  final String id;
  final bool clickable;
  final double? height;
  final double? width;
  final bool? showBorders;
  final String? parentId;
  final Function()? onTap;

  const HomeCategory({
    required this.image,
    required this.title,
    required this.id,
    this.clickable = true,
    this.showBorders,
    this.height,
    this.width,
    this.parentId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return InkWell(
      onTap: onTap ??
          () {
            if (id == "5") {
              Navigator.of(context).pushNamed(
                UtilitiesScreen.routName,
                arguments: id,
              );
            } else if (id == "14") {
              Navigator.of(context).pushNamed(
                VehicleTaxScreen.routName,
                arguments: id,
              );
            } else if (id == "3") {
              Navigator.of(context).pushNamed(
                DomesticMobileRecharge.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Domestic Mobile Recharge",
                },
              );
            } else if (id == "8") {
              Navigator.of(context).pushNamed(
                IntlMobileTopupScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Int'l Mobile TopUp",
                },
              );
            } else if (id == "4") {
              Navigator.of(context).pushNamed(
                IntlLongDistanceScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Int'l Long Distance",
                },
              );
            } else if (id == "7") {
              Navigator.of(context).pushNamed(
                MobileDataScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Mobile Data",
                },
              );
            } else if (id == "19") {
              Navigator.of(context).pushNamed(
                ComCastScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "COMCAST",
                  "parentId": parentId,
                },
              );
            } else if (id == "30") {
              Navigator.of(context).pushNamed(
                PrepaidXfinityScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "PREPAID XFINITY",
                  "parentId": parentId,
                },
              );
            } else if (id == "26") {
              Navigator.of(context).pushNamed(
                SewerageScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "WATER / SEWERAGE",
                  "parentId": parentId,
                },
              );
            } else if (id == "27") {
              Navigator.of(context).pushNamed(
                SewerageScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "ELECTRIC BILL",
                  "parentId": parentId,
                },
              );
            } else if (id == "6") {
              Navigator.of(context).pushNamed(
                CarInsuranceScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Car Insurance",
                },
              );
            } else if (id == "10") {
              Navigator.of(context).pushNamed(
                GifCardTopupScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "Gift Cards",
                },
              );
            } else if (id == "12") {
              Navigator.of(context).pushNamed(
                NewActivationScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "NEW ACTIVATION",
                },
              );
            } else if (id == "11") {
              Navigator.of(context).pushNamed(
                PortInScreen.routName,
                arguments: {
                  "category": CategoryModel(
                    id: id,
                    categoryIcon: image,
                    categoryName: title,
                  ),
                  "title": "PORT-IN ",
                },
              );
            }
          },
      child: Card(
        elevation: showBorders == false ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: showBorders == false
                ? null
                : [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0, 1.5),
                      spreadRadius: 1.5,
                      blurRadius: 1.5,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(1.5, 0),
                      spreadRadius: 1.5,
                      blurRadius: 1.5,
                    ),
                  ],
          ),
          child: Column(
            children: [
              FadeInImage(
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height / 14.5,
                width: MediaQuery.of(context).size.width / 4,
                placeholder: const AssetImage("assets/images/placeholder.png"),
                image: NetworkImage("$categoryImgUrl$image"),
                imageErrorBuilder: (ctx, obj, st) {
                  return Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.fill,
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 1.2 * unitHeightValue,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
