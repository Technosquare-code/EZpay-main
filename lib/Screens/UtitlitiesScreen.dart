import 'package:billapp/Components/CategoryLoading.dart';
import 'package:billapp/Components/HomeCategory.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Providers/SubCategoryProvider.dart';
import 'package:billapp/Screens/ComCastScreen.dart';
import 'package:billapp/Screens/PrepaidXfinityScreen.dart';
import 'package:billapp/package%20edit/responsive_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UtilitiesScreen extends StatefulWidget {
  static const routName = "/UtilitiesScreen";

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  late String categoryId;

  @override
  void didChangeDependencies() {
    categoryId = ModalRoute.of(context)!.settings.arguments.toString();
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    Provider.of<SubCategoryProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
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
        title: const Text(
          "Utilities",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<SubCategoryProvider>(builder: (context, value, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: value.subCategories != null
                ? ResponsiveGridList(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    minItemWidth: MediaQuery.of(context).size.width / 4,
                    maxItemsPerRow: 3,
                    children: List.generate(
                      value.subCategories!.length,
                      (i) => HomeCategory(
                        showBorders: false,
                        parentId: categoryId,
                        image: value.subCategories![i].image.toString(),
                        title: value.subCategories![i].name.toString(),
                        id: value.subCategories![i].id.toString(),
                        onTap: () {
                          if (value.subCategories![i].id.toString() == "30") {
                            Navigator.of(context).pushNamed(
                              PrepaidXfinityScreen.routName,
                              arguments: {
                                "category": CategoryModel(
                                  id: value.subCategories![i].id.toString(),
                                  categoryIcon:
                                      value.subCategories![i].image.toString(),
                                  categoryName:
                                      value.subCategories![i].name.toString(),
                                ),
                                "title": "PREPAID XFINITY",
                                "parentId": categoryId,
                              },
                            );
                          } else {
                            Navigator.of(context).pushNamed(
                              ComCastScreen.routName,
                              arguments: {
                                "category": CategoryModel(
                                  id: value.subCategories![i].id.toString(),
                                  categoryIcon:
                                      value.subCategories![i].image.toString(),
                                  categoryName:
                                      value.subCategories![i].name.toString(),
                                ),
                                "title":
                                    value.subCategories![i].name.toString(),
                                "parentId": categoryId,
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: value.getSubCategories(categoryId),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CategoryLoading();
                      } else {
                        return NetWorkError();
                      }
                    },
                  ),
          ),
        );
      }),
    );
  }
}
