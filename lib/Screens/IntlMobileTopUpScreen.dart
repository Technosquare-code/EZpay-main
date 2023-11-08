import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyDropDown.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/Plan.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/CountryModel.dart';
import 'package:billapp/Models/NetworkModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/MobileTopUpProvider.dart';
import 'package:billapp/Screens/MobileTopUpCheckout.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/package%20edit/responsive_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class IntlMobileTopupScreen extends StatefulWidget {
  static const routName = "/IntlMobileTopupScreen";
  @override
  _IntlMobileTopupScreenState createState() => _IntlMobileTopupScreenState();
}

class _IntlMobileTopupScreenState extends State<IntlMobileTopupScreen> {
  bool getInput = false;
  String selectedIndex = "";
  NetworkModel? netwok;
  CountryModel? country;
  late String title;
  late CategoryModel category;
  List planList = [];
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final mobileController = TextEditingController();
  final confirmController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  getNetworks(String countryCode) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 200));
    context.loaderOverlay.show();
    await Provider.of<MobileTopupProvider>(context, listen: false)
        .getNetworks(countryCode);
    context.loaderOverlay.hide();
  }

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      // selectedIndex = planList.first;
      // amountController.text = "${planList.first}";
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    amountController.dispose();
    mobileController.dispose();
    confirmController.dispose();
    super.dispose();
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
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
        child: Consumer<MobileTopupProvider>(builder: (context, value, child) {
          return SafeArea(
            child: value.countries != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Center(
                            child: InnerCategory(
                              category.categoryIcon.toString(),
                              category.categoryName.toString(),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            translator.getString("IntlMobile.mobile"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InputField(
                            color: Colors.white,
                            hint: translator.getString("IntlMobile.mobileHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: mobileController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("IntlMobile.mobileEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("IntlMobile.mobileConfirm"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InputField(
                            color: Colors.white,
                            hint: translator
                                .getString("IntlMobile.mobileConfirmHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: confirmController,
                            borderColor: Colors.grey,
                            validator: (c) {
                              if (c == null || c == "") {
                                return "* ${translator.getString("IntlMobile.mobileConfirmEmpty")}!";
                              } else if (c != mobileController.text) {
                                return "* ${translator.getString("IntlMobile.mobileConfirmError")}!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("IntlMobile.country"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          MyDropdown(
                            value: country,
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint:
                                translator.getString("IntlMobile.countryHint"),
                            items: value.countries,
                            onChanged: (c) {
                              setState(() {
                                country = c as CountryModel;
                              });
                              netwok = null;
                              getNetworks(country!.isoName.toString());
                            },
                            validator: (c) {
                              if (c == null) {
                                return translator
                                    .getString("IntlMobile.countryEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("IntlMobile.network"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyDropdown(
                            value: netwok,
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint:
                                translator.getString("IntlMobile.networkHint"),
                            items: value.networks,
                            onChanged: (n) {
                              setState(() {
                                netwok = n as NetworkModel;
                                if (netwok!.suggestedAmounts!.isNotEmpty) {
                                  planList = netwok!.suggestedAmounts as List;
                                  selectedIndex = planList[0];
                                } else if (netwok!
                                    .localFixedAmounts!.isNotEmpty) {
                                  planList = netwok!.localFixedAmounts as List;
                                  selectedIndex = planList[0];
                                } else {
                                  planList = [
                                    "5",
                                    "10",
                                    "15",
                                    "20",
                                    "25",
                                    "30"
                                  ];
                                  selectedIndex = planList[0];
                                }
                              });
                            },
                            validator: (n) {
                              if (n == null) {
                                return translator
                                    .getString("IntlMobile.networkEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          if (planList.isNotEmpty)
                            Text(
                              translator.getString("IntlMobile.plan"),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (planList.isNotEmpty) const SizedBox(height: 5),
                          if (planList.isNotEmpty)
                            ResponsiveGridList(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              minItemWidth:
                                  MediaQuery.of(context).size.width / 2.5,
                              children: List.generate(
                                planList.length,
                                (i) => Plan(
                                  index: planList[i],
                                  currency: country != null
                                      ? country!.currencySymbol
                                      : null,
                                  selectedIndex: selectedIndex,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = planList[i];
                                    });
                                    amountController.text = selectedIndex;
                                  },
                                ),
                              ),
                            ),
                          if (planList.isNotEmpty) const SizedBox(height: 25),
                          Text(
                            translator.getString("IntlMobile.amount"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InputField(
                            color: Colors.white,
                            hint: translator.getString("IntlMobile.amountHint"),
                            textIcon: country == null
                                ? "\$"
                                : country!.currencySymbol,
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("IntlMobile.amountEmpty")}!",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: MyColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  45,
                                ),
                              ),
                              child: Text(
                                translator.getString("IntlMobile.textButton"),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).pushReplacementNamed(
                                    MobileTopupCheckout.routName,
                                    arguments: {
                                      "category": category,
                                      "amount": amountController.text,
                                      "mobile": mobileController.text,
                                      "country": country,
                                      "network": netwok,
                                      "currency": country!.currencySymbol,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: value.getData(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyLoading();
                      } else {
                        return NetWorkError();
                      }
                    },
                  ),
          );
        }),
      ),
    );
  }
}
