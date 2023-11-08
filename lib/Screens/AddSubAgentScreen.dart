import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/PasswordInputField.dart';
import 'package:billapp/Models/SubAgentModel.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/SubAgentProvider.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class AddSubAgentScreen extends StatefulWidget {
  static const routName = "/AddSubAgentScreen";
  @override
  State<AddSubAgentScreen> createState() => _AddSubAgentScreenState();
}

class _AddSubAgentScreenState extends State<AddSubAgentScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  addSubAgent() async {
    if (_formKey.currentState!.validate()) {
      var auth = Provider.of<AuthProvider>(context, listen: false);
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      context.loaderOverlay.show();
      Provider.of<SubAgentProvider>(context, listen: false)
          .addSubAgent(
        SubAgentModel(
          id: "",
          name: userNameController.text,
          city: cityController.text,
          address: addressController.text,
          email: emailController.text,
          mobile: mobileController.text,
          password: passwordController.text,
          postCode: postalCodeController.text,
        ),
        auth.currentUser!.id.toString(),
      )
          .then((value) {
        if (value == "23") {
          context.loaderOverlay.hide();
          Utils().showSuccessDialog(
            context,
            translator.getString("code$value"),
            () {
              Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                Navigator.of(context).pop();
              });
            },
            fontSize: 18,
          );
        } else {
          context.loaderOverlay.hide();
          Utils().showErrorDialog(context, translator.getString("code$value"));
        }
      });
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            ),
            label: Text(
              translator.getString("AddSubAgent.title"),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translator.getString("AddSubAgent.name"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.nameHint"),
                  icon: Icons.person,
                  color: Colors.white,
                  errorTextColor: Colors.red,
                  borderColor: Colors.grey,
                  type: TextInputType.name,
                  controller: userNameController,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("AddSubAgent.nameEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.phone"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.phoneHint"),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  icon: Icons.phone_android,
                  type: TextInputType.number,
                  errorTextColor: Colors.red,
                  controller: mobileController,
                  validator: (v) {
                    if (v == "" || v == null) {
                      return "* ${translator.getString("AddSubAgent.phoneEmpty")}!";
                    } else if (v.length < 9 || v.length > 11) {
                      return "* ${translator.getString("AddSubAgent.phoneError")}!";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.email"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.emailHint"),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  errorTextColor: Colors.red,
                  icon: Icons.mail,
                  type: TextInputType.emailAddress,
                  controller: emailController,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText:
                          "* ${translator.getString("AddSubAgent.emailEmpty")}!",
                    ),
                    EmailValidator(
                      errorText:
                          "* ${translator.getString("AddSubAgent.emailError")}!",
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.password"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                PasswordInputField(
                  hint: translator.getString("AddSubAgent.passwordHint"),
                  icon: Icons.lock,
                  color: Colors.white,
                  borderColor: Colors.grey,
                  errorTextColor: Colors.red,
                  controller: passwordController,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText:
                          "* ${translator.getString("AddSubAgent.passwordEmpty")}!",
                    ),
                    MinLengthValidator(
                      6,
                      errorText:
                          "* ${translator.getString("AddSubAgent.passwordError")}!",
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.confirmPass"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                PasswordInputField(
                  hint: translator.getString("AddSubAgent.confirmPassHint"),
                  icon: Icons.lock,
                  color: Colors.white,
                  errorTextColor: Colors.red,
                  borderColor: Colors.grey,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "* ${translator.getString("AddSubAgent.confirmPassEmpty")}!";
                    } else if (value != passwordController.text) {
                      return "* ${translator.getString("AddSubAgent.confirmPassError")}!";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.city"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.cityHint"),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  icon: Icons.place,
                  type: TextInputType.name,
                  errorTextColor: Colors.red,
                  controller: cityController,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("AddSubAgent.cityEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.address"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.addressHint"),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  icon: Icons.home,
                  errorTextColor: Colors.red,
                  type: TextInputType.streetAddress,
                  controller: addressController,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("AddSubAgent.addressEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("AddSubAgent.postalCode"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  hint: translator.getString("AddSubAgent.postalCodeHint"),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  icon: Icons.contact_mail,
                  errorTextColor: Colors.red,
                  type: TextInputType.visiblePassword,
                  controller: postalCodeController,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("AddSubAgent.postalCodeEmpty")}!",
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
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
                    translator.getString("AddSubAgent.textButton"),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  onPressed: addSubAgent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
