import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Components/Plan.dart';
import 'package:billapp/Models/PlanModel.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:billapp/package%20edit/responsive_grid_list.dart';

class PrepaidXfinityScreen extends StatefulWidget {
  static const routName = "/PrepaidXfinityScreen";
  @override
  _PrepaidXfinityScreenState createState() => _PrepaidXfinityScreenState();
}

class _PrepaidXfinityScreenState extends State<PrepaidXfinityScreen> {
  bool getInput = false;
  String selectedIndex = "";
  PlanModel? plan;
  late String title;
  late String parentId;
  late CategoryModel category;
  List<PlanModel> planList = [];
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final confirmController = TextEditingController();
  final accountController = TextEditingController();
  final zipController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      parentId = arg["parentId"];
      Provider.of<CategoriesProvider>(context, listen: false)
          .getPlans(parentId, category.id.toString())
          .then((value) {
        setState(() {
          if (value.isNotEmpty) {
            planList = value;
            plan = value.first;
          }
          getInput = true;
        });
        // plan = planList.first.id;
        // selectedIndex = planList.first.planPrice.toString();
        // amountController.text = "${planList.first.planPrice}";
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController.dispose();
    confirmController.dispose();
    accountController.dispose();
    zipController.dispose();
    amountController.dispose();
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
        child: SafeArea(
          child: getInput == false
              ? MyLoading()
              : SingleChildScrollView(
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
                          translator.getString("PrepaidXfinity.mobile"),
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
                          hint:
                              translator.getString("PrepaidXfinity.mobileHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: mobileController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("PrepaidXfinity.mobileEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("PrepaidXfinity.mobileConfirm"),
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
                              .getString("PrepaidXfinity.mobileConfirmHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: confirmController,
                          borderColor: Colors.grey,
                          validator: (val) {
                            if (val == null || val == "") {
                              return "* ${translator.getString("PrepaidXfinity.mobileConfirmEmpty")}!";
                            } else if (val != mobileController.text) {
                              return "* ${translator.getString("PrepaidXfinity.mobileConfirmError")}!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("PrepaidXfinity.account"),
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
                              .getString("PrepaidXfinity.accountHint"),
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: accountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("PrepaidXfinity.accountEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("PrepaidXfinity.zipcode"),
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
                              .getString("PrepaidXfinity.zipcodeHint"),
                          type: TextInputType.visiblePassword,
                          errorTextColor: Colors.red,
                          controller: zipController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("PrepaidXfinity.zipcodeEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (planList.isNotEmpty)
                          Text(
                            translator.getString("PrepaidXfinity.plan"),
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
                                title: planList[i].planIcon,
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
                          translator.getString("PrepaidXfinity.amount"),
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
                          hint:
                              translator.getString("PrepaidXfinity.amountHint"),
                          textIcon: "\$",
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: amountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("PrepaidXfinity.amountEmpty")}!",
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
                              translator.getString("PrepaidXfinity.textButton"),
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
                                    "plan": plan!.id,
                                    "category": category,
                                    "amount": amountController.text,
                                    "mobile": mobileController.text,
                                    "zipcode": zipController.text,
                                    "account": accountController.text,
                                    "comission": plan!.comission,
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
