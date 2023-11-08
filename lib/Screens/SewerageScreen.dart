import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Components/Plan.dart';
import 'package:billapp/Models/PlanModel.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:billapp/package%20edit/responsive_grid_list.dart';

class SewerageScreen extends StatefulWidget {
  static const routName = "/SewerageScreen";
  @override
  _SewerageScreenState createState() => _SewerageScreenState();
}

class _SewerageScreenState extends State<SewerageScreen> {
  bool getInput = false;
  late String title;
  late String parentId;
  late CategoryModel category;
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final confirmController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final accountController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      parentId = arg["parentId"];
      getInput = true;
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController.dispose();
    confirmController.dispose();
    stateController.dispose();
    cityController.dispose();
    accountController.dispose();
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
                          translator.getString("Sewerage.mobile"),
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
                          hint: translator.getString("Sewerage.mobileHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: mobileController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("Sewerage.mobileEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("Sewerage.mobileConfirm"),
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
                              .getString("Sewerage.mobileConfirmHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: confirmController,
                          borderColor: Colors.grey,
                          validator: (val) {
                            if (val == null || val == "") {
                              return "* ${translator.getString("Sewerage.mobileConfirmEmpty")}!";
                            } else if (val != mobileController.text) {
                              return "* ${translator.getString("Sewerage.mobileConfirmError")}!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("Sewerage.state"),
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
                          hint: translator.getString("Sewerage.stateHint"),
                          type: TextInputType.name,
                          errorTextColor: Colors.red,
                          controller: stateController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("Sewerage.stateEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("Sewerage.city"),
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
                          hint: translator.getString("Sewerage.cityHint"),
                          type: TextInputType.name,
                          errorTextColor: Colors.red,
                          controller: cityController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("Sewerage.cityEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("Sewerage.account"),
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
                          hint: translator.getString("Sewerage.accountHint"),
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: accountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("Sewerage.accountEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("Sewerage.amount"),
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
                          hint: translator.getString("Sewerage.amountHint"),
                          textIcon: "\$",
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: amountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("Sewerage.amountEmpty")}!",
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
                              translator.getString("Sewerage.textButton"),
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
                                    "category": category,
                                    "amount": amountController.text,
                                    "mobile": mobileController.text,
                                    "state": stateController.text,
                                    "city": cityController.text,
                                    "account": accountController.text,
                                    "comission": "0",
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
