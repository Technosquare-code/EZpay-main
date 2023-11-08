import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyDropDown.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/Plan.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/PlanModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
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

class DomesticMobileRecharge extends StatefulWidget {
  static const routName = "/DomesticMobileRecharge";
  @override
  _DomesticMobileRechargeState createState() => _DomesticMobileRechargeState();
}

class _DomesticMobileRechargeState extends State<DomesticMobileRecharge> {
  bool getInput = false;
  bool amountEditable = false;
  String selectedIndex = "";
  PlanModel? plan;
  late String title;
  late CategoryModel category;
  List<PlanModel> planList = [];
  List<SubCategoryModel> lines = [
    SubCategoryModel(image: "", name: "1"),
    SubCategoryModel(image: "", name: "2"),
    SubCategoryModel(image: "", name: "3"),
    SubCategoryModel(image: "", name: "4"),
    SubCategoryModel(image: "", name: "5"),
    SubCategoryModel(image: "", name: "6"),
  ];
  SubCategoryModel? selectedLine;
  SubCategoryModel? subCategory;
  final _formKey = GlobalKey<FormState>();
  final mobileController1 = TextEditingController();
  final mobileController2 = TextEditingController();
  final mobileController3 = TextEditingController();
  final mobileController4 = TextEditingController();
  final mobileController5 = TextEditingController();
  final mobileController6 = TextEditingController();
  final confirmController1 = TextEditingController();
  final confirmController2 = TextEditingController();
  final confirmController3 = TextEditingController();
  final confirmController4 = TextEditingController();
  final confirmController5 = TextEditingController();
  final confirmController6 = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  getPlans(String subCategoryId) async {
    context.loaderOverlay.show();
    List<PlanModel> result =
        await Provider.of<CategoriesProvider>(context, listen: false)
            .getPlans(category.id.toString(), subCategoryId);
    if (result.isNotEmpty) {
      setState(() {
        planList = result;
        plan = planList.first;
        selectedIndex = planList.first.planPrice.toString();
        amountController.text = planList.first.planPrice.toString();
      });
    }
    context.loaderOverlay.hide();
  }

  @override
  void deactivate() {
    Provider.of<CategoriesProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      // selectedIndex = planList.first.planPrice.toString();
      // amountController.text = "${planList.first.planPrice}";
      selectedLine = lines.first;
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController1.dispose();
    mobileController2.dispose();
    mobileController3.dispose();
    mobileController4.dispose();
    mobileController5.dispose();
    mobileController6.dispose();
    confirmController1.dispose();
    confirmController2.dispose();
    confirmController3.dispose();
    confirmController4.dispose();
    confirmController5.dispose();
    confirmController6.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      disableBackButton: true,
      overlayWidget: const Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
      child: Scaffold(
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
        body: SafeArea(
          child: Consumer<CategoriesProvider>(builder: (context, value, child) {
            return value.subCategories != null
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
                            translator.getString("Domestic.line"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyDropdown(
                            value: selectedLine,
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint: translator.getString("Domestic.lineHint"),
                            items: lines,
                            onChanged: (s) {
                              selectedLine = (s as SubCategoryModel);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 1)
                            Text(
                              "${translator.getString("Domestic.mobile")} 1",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 1)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 1)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 1",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController1,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 1)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 1)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 1",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 1)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 1)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 1",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController1,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController1.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 1)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 2)
                            Text(
                              "${translator.getString("Domestic.mobile")} 2",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 2)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 2)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 2",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController2,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 2)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 2)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 2",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 2)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 2)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 2",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController2,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController2.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 2)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 3)
                            Text(
                              "${translator.getString("Domestic.mobile")} 3",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 3)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 3)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 3",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController3,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 3)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 3)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 3",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 3)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 3)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 3",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController3,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController3.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 3)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 4)
                            Text(
                              "${translator.getString("Domestic.mobile")} 4",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 4)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 4)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 4",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController4,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 4)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 4)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 4",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 4)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 4)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 4",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController4,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController4.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 4)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 5)
                            Text(
                              "${translator.getString("Domestic.mobile")} 5",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 5)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 5)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 5",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController5,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 5)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 5)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 5",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 5)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 5)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 5",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController5,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController5.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 5)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 6)
                            Text(
                              "${translator.getString("Domestic.mobile")} 6",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 6)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 6)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileHint")} 6",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: mobileController6,
                              borderColor: Colors.grey,
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Domestic.mobileEmpty")}!",
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 6)
                            const SizedBox(height: 15),
                          if (int.parse(selectedLine!.name!) >= 6)
                            Text(
                              "${translator.getString("Domestic.mobileConfirm")} 6",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (int.parse(selectedLine!.name!) >= 6)
                            const SizedBox(height: 5),
                          if (int.parse(selectedLine!.name!) >= 6)
                            InputField(
                              color: Colors.white,
                              hint:
                                  "${translator.getString("Domestic.mobileConfirmHint")} 6",
                              type: TextInputType.phone,
                              errorTextColor: Colors.red,
                              controller: confirmController6,
                              borderColor: Colors.grey,
                              validator: (val) {
                                if (val == null || val == "") {
                                  return "* ${translator.getString("Domestic.mobileConfirmEmpty")}!";
                                } else if (val != mobileController6.text) {
                                  return "* ${translator.getString("Domestic.mobileConfirmError")}!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          if (int.parse(selectedLine!.name!) >= 6)
                            const SizedBox(height: 15),
                          Text(
                            translator.getString("Domestic.carrier"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyDropdown(
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint: translator.getString("Domestic.carrierHint"),
                            items: value.subCategories,
                            onChanged: (s) {
                              subCategory = s as SubCategoryModel;
                              print(s.name);
                              if (s.name == "AT&T POSTPAID" ||
                                  s.name == "T-MOBILE POSTPAID" ||
                                  s.name == "VERIZON POSTPAID") {
                                print("Hello");
                                amountEditable = true;
                              }
                              setState(() {});
                              getPlans(subCategory!.id.toString());
                            },
                            validator: (c) {
                              if (c == null) {
                                return translator
                                    .getString("Domestic.carrierEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          if (planList.isNotEmpty)
                            Text(
                              translator.getString("Domestic.plan"),
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
                                  index: planList[i].planPrice.toString(),
                                  title: planList[i].planName,
                                  selectedIndex: selectedIndex,
                                  image: planList[i].planIcon,
                                  onTap: () {
                                    selectedIndex = planList[i].planPrice!;
                                    plan = planList[i];
                                    setState(() {});
                                    amountController.text =
                                        "${planList[i].planPrice}";
                                  },
                                ),
                              ),
                            ),
                          if (planList.isNotEmpty) const SizedBox(height: 25),
                          Text(
                            translator.getString("Domestic.amount"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InputField(
                            readOnly: !amountEditable,
                            color: Colors.white,
                            hint: translator.getString("Domestic.amountHint"),
                            textIcon: "\$",
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Domestic.amountEmpty")}!",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  45,
                                ),
                              ),
                              child: Text(
                                translator.getString("Domestic.textButton"),
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
                                    ProductCheckoutScreen.routName,
                                    arguments: {
                                      "plan": amountEditable ? "" : plan!.id,
                                      "category": category,
                                      "amount": amountController.text,
                                      "mobile": mobileController1.text,
                                      "mobile2": mobileController2.text,
                                      "mobile3": mobileController3.text,
                                      "mobile4": mobileController4.text,
                                      "mobile5": mobileController5.text,
                                      "mobile6": mobileController6.text,
                                      "carrier": subCategory,
                                      "comission":
                                          amountEditable ? "" : plan!.comission,
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
                    future: value.getSubCategories(category.id.toString()),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyLoading();
                      } else {
                        return NetWorkError();
                      }
                    },
                  );
          }),
        ),
      ),
    );
  }
}
