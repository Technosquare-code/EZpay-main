import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ComCastScreen extends StatefulWidget {
  static const routName = "/ComCastScreen";
  @override
  _ComCastScreenState createState() => _ComCastScreenState();
}

class _ComCastScreenState extends State<ComCastScreen> {
  bool getInput = false;
  String selectedIndex = "";
  late String title;
  late String parentId;
  late CategoryModel category;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
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
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    confirmController.dispose();
    emailController.dispose();
    addressController.dispose();
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
                          translator.getString("ComCast.firstName"),
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
                          hint: translator.getString("ComCast.firstNameHint"),
                          type: TextInputType.name,
                          errorTextColor: Colors.red,
                          controller: firstNameController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.firstNameEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.lastName"),
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
                          hint: translator.getString("ComCast.lastNameHint"),
                          type: TextInputType.name,
                          errorTextColor: Colors.red,
                          controller: lastNameController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.lastNameEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.phone"),
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
                          hint: translator.getString("ComCast.phoneHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: phoneController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.phoneEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.confirm"),
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
                          hint: translator.getString("ComCast.confirmHint"),
                          type: TextInputType.phone,
                          errorTextColor: Colors.red,
                          controller: confirmController,
                          borderColor: Colors.grey,
                          validator: (p) {
                            if (p == null || p == "") {
                              return "* ${translator.getString("ComCast.confirmEmpty")}!";
                            } else if (p != phoneController.text) {
                              return "* ${translator.getString("ComCast.confirmError")}!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.email"),
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
                          hint: translator.getString("ComCast.emailHint"),
                          type: TextInputType.emailAddress,
                          errorTextColor: Colors.red,
                          controller: emailController,
                          borderColor: Colors.grey,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText:
                                  "* ${translator.getString("ComCast.emailEmpty")}!",
                            ),
                            EmailValidator(
                              errorText:
                                  "* ${translator.getString("ComCast.emailError")}!",
                            ),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.address"),
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
                          hint: translator.getString("ComCast.addressHint"),
                          type: TextInputType.streetAddress,
                          errorTextColor: Colors.red,
                          controller: addressController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.addressEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.account"),
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
                          hint: translator.getString("ComCast.accountHint"),
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: accountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.accountEmpty")}!",
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          translator.getString("ComCast.amount"),
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
                          hint: translator.getString("ComCast.amountHint"),
                          textIcon: "\$",
                          type: TextInputType.number,
                          errorTextColor: Colors.red,
                          controller: amountController,
                          borderColor: Colors.grey,
                          validator: RequiredValidator(
                            errorText:
                                "* ${translator.getString("ComCast.amountEmpty")}!",
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
                              translator.getString("ComCast.textButton"),
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
                                    "firstName": firstNameController.text,
                                    "lastName": lastNameController.text,
                                    "address": addressController.text,
                                    "account": accountController.text,
                                    "mobile": phoneController.text,
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
      ),
    );
  }
}
