import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyDatePicker.dart';
import 'package:billapp/Components/MyDropDown.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class CarInsuranceScreen extends StatefulWidget {
  static const routName = "/CarInsuranceScreen";
  @override
  _CarInsuranceScreenState createState() => _CarInsuranceScreenState();
}

class _CarInsuranceScreenState extends State<CarInsuranceScreen> {
  bool getInput = false;
  SubCategoryModel? subCategory;
  late String title;
  late CategoryModel category;
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final confirmController = TextEditingController();
  final dobController = TextEditingController();
  final zipController = TextEditingController();
  final accountController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

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
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController.dispose();
    confirmController.dispose();
    dobController.dispose();
    zipController.dispose();
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
        child: Consumer<CategoriesProvider>(builder: (context, value, child) {
          return SafeArea(
            child: value.subCategories != null
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
                            translator.getString("Car.mobile"),
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
                            hint: translator.getString("Car.mobileHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: mobileController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Car.mobileEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.mobileConfirm"),
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
                            hint: translator.getString("Car.mobileConfirmHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: confirmController,
                            borderColor: Colors.grey,
                            validator: (m) {
                              if (m == null || m == "") {
                                return "* ${translator.getString("Car.mobileConfirmEmpty")}!";
                              } else if (m != mobileController.text) {
                                return "* ${translator.getString("Car.mobileConfirmError")}!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.dob"),
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
                            readOnly: true,
                            onTap: () async {
                              var r = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (ctx) => const MyDatePicker(),
                              );
                              if (r != null) {
                                dobController.text = r.toString().split(" ")[0];
                              }
                            },
                            hint: translator.getString("Car.dobHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: dobController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Car.dobEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.zip"),
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
                            hint: translator.getString("Car.zipHint"),
                            type: TextInputType.visiblePassword,
                            errorTextColor: Colors.red,
                            controller: zipController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Car.zipEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.company"),
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
                            hint: translator.getString("Car.companyHint"),
                            items: value.subCategories,
                            onChanged: (s) {
                              setState(() {
                                subCategory = s as SubCategoryModel;
                              });
                            },
                            validator: (c) {
                              if (c == null) {
                                return "* ${translator.getString("Car.companyEmpty")}!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.account"),
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
                            hint: translator.getString("Car.accountHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: accountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Car.accountEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Car.amount"),
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
                            hint: translator.getString("Car.amountHint"),
                            textIcon: "\$",
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Car.amountEmpty")}!",
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
                                translator.getString("Car.textButton"),
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
                                      "zipcode": zipController.text,
                                      "dob": dobController.text,
                                      "company": subCategory,
                                      "account": accountController.text,
                                      "comission": "",
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
                  ),
          );
        }),
      ),
    );
  }
}
