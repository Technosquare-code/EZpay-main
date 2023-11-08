import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routName = "/changePasswordScreen";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  changePassword() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      context.loaderOverlay.show();
      var auth = Provider.of<AuthProvider>(context, listen: false);
      auth
          .changePassword(
        oldPasswordController.text,
        passwordController.text,
      )
          .then((value) {
        if (value == "13") {
          context.loaderOverlay.hide();
          Utils().showSuccessDialog(
            context,
            translator.getString("code$value"),
            () {
              oldPasswordController.text = "";
              passwordController.text = "";
              confirmPasswordController.text = "";
              Navigator.of(context).pop();
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
    passwordController.dispose();
    oldPasswordController.dispose();
    confirmPasswordController.dispose();
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
            translator.getString("ChangePassword.title"),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height / 1.15,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translator.getString("ChangePassword.oldPass"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                InputField(
                  controller: oldPasswordController,
                  hint: translator.getString("ChangePassword.oldPassHint"),
                  color: Colors.white,
                  borderColor: Colors.blue,
                  errorTextColor: Colors.red,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("ChangePassword.oldPassEmpty")}!",
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  translator.getString("ChangePassword.newPass"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                InputField(
                  controller: passwordController,
                  hint: translator.getString("ChangePassword.newPassHint"),
                  color: Colors.white,
                  borderColor: Colors.blue,
                  errorTextColor: Colors.red,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText:
                          "* ${translator.getString("ChangePassword.newPassEmpty")}!",
                    ),
                    MinLengthValidator(
                      6,
                      errorText:
                          "* ${translator.getString("ChangePassword.newPassError")}!",
                    ),
                  ]),
                ),
                const SizedBox(height: 25),
                Text(
                  translator.getString("ChangePassword.confimPass"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                InputField(
                  controller: confirmPasswordController,
                  hint: translator.getString("ChangePassword.confimPassHint"),
                  color: Colors.white,
                  borderColor: Colors.blue,
                  errorTextColor: Colors.red,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "* ${translator.getString("ChangePassword.confimPassEmpty")}!";
                    } else if (value != passwordController.text) {
                      return "* ${translator.getString("ChangePassword.confimPassError")}!";
                    } else {
                      return null;
                    }
                  },
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
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
                      translator.getString("ChangePassword.textButton"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: changePassword,
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
