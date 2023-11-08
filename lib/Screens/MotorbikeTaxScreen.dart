import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Components/InnerCategory.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class MotorbikeTaxScreen extends StatefulWidget {
  static const routName = "/MotorbikeTaxScreen";
  @override
  _MotorbikeTaxScreenState createState() => _MotorbikeTaxScreenState();
}

class _MotorbikeTaxScreenState extends State<MotorbikeTaxScreen> {
  bool getInput = false;
  SubCategoryModel? subCategory;
  late String title;
  late CategoryModel category;
  final _formKey = GlobalKey<FormState>();
  final lastNameController = TextEditingController();
  final licenseController = TextEditingController();
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

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
    lastNameController.dispose();
    licenseController.dispose();
    emailController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                  translator.getString("Motorbike.lastName"),
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
                  hint: translator.getString("Motorbike.lastNameHint"),
                  type: TextInputType.name,
                  errorTextColor: Colors.red,
                  controller: lastNameController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Motorbike.lastNameEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Motorbike.license"),
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
                  hint: translator.getString("Motorbike.licenseHint"),
                  type: TextInputType.visiblePassword,
                  errorTextColor: Colors.red,
                  controller: licenseController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Motorbike.licenseEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Motorbike.email"),
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
                  hint: translator.getString("Motorbike.emailHint"),
                  type: TextInputType.emailAddress,
                  errorTextColor: Colors.red,
                  controller: emailController,
                  borderColor: Colors.grey,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText:
                          "* ${translator.getString("Motorbike.emailEmpty")}!",
                    ),
                    EmailValidator(
                      errorText:
                          "* ${translator.getString("Motorbike.emailError")}!",
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Motorbike.amount"),
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
                  hint: translator.getString("Motorbike.amountHint"),
                  textIcon: "\$",
                  type: TextInputType.number,
                  errorTextColor: Colors.red,
                  controller: amountController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Motorbike.amountEmpty")}!",
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
                      translator.getString("Motorbike.textButton"),
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
                            "category": CategoryModel(
                              categoryIcon: category.categoryIcon,
                              categoryName:
                                  category.categoryName!.toLowerCase(),
                              id: category.id,
                            ),
                            "amount": amountController.text,
                            "lastName": lastNameController.text,
                            "plate": licenseController.text,
                            "email": emailController.text,
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
        ),
      ),
    );
  }
}
