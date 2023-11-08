import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/PasswordInputField.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Screens/DashboardScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool savePassword = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneFocus = FocusNode();
  final translator = TranslatorGenerator.instance;

  forgotPassword(String mobile) {
    context.loaderOverlay.show();
    Provider.of<AuthProvider>(context, listen: false)
        .forgotPassword(mobile)
        .then((value) {
      context.loaderOverlay.hide();
      if (value == "19") {
        Utils().showSuccessDialog(
          context,
          translator.getString("code$value"),
          () => Navigator.of(context).pop(),
        );
      } else {
        Utils().showErrorDialog(context, translator.getString("code$value"));
      }
    });
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.loaderOverlay.show();
      var auth = Provider.of<AuthProvider>(context, listen: false);
      auth
          .login(emailController.text, passwordController.text)
          .then((value) async {
        context.loaderOverlay.hide();
        if (value == "4") {
          if (savePassword == true) {
            await auth.savePassword(
              passwordController.text,
              emailController.text,
            );
          }
          Navigator.of(context).pushReplacementNamed(DashboardScreen.routName);
        } else {
          Utils().showErrorDialog(context, translator.getString("code$value"));
        }
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var auth = Provider.of<AuthProvider>(context, listen: false);
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
        backgroundColor: MyColor.primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColor.primaryColor,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColor.primaryColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.15,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 50,
                    ),
                    child: Image.asset(
                      "assets/images/logo1.png",
                      fit: BoxFit.fill,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    hint: translator.getString("login.emailHint"),
                    color: Colors.white,
                    icon: Icons.mail,
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: translator.getString("login.emailEmpty"),
                      ),
                      EmailValidator(
                        errorText: translator.getString("login.emailError"),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  PasswordInputField(
                    controller: passwordController,
                    hint: translator.getString("login.passwordHint"),
                    icon: Icons.lock,
                    color: Colors.white,
                    validator: RequiredValidator(
                      errorText:
                          "* ${translator.getString("login.passwordEmpty")}!",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Checkbox(
                          activeColor: MyColor.secondaryColor,
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: const BorderSide(color: Colors.transparent),
                          value: savePassword,
                          onChanged: (v) {
                            setState(() {
                              savePassword = v!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        translator.getString("login.savePass"),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColor.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        45,
                      ),
                    ),
                    child: Text(
                      translator.getString("login.textButton"),
                      style: TextStyle(
                        fontSize: 18,
                        color: MyColor.primaryColor,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: login,
                  ),
                  const SizedBox(height: 35),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => ForgotPassword(forgotPassword),
                      );
                    },
                    child: Text(
                      "${translator.getString("login.forgot")} ",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 50,
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: MyColor.primaryColor,
                  //       borderRadius: BorderRadius.circular(5),
                  //       border: Border.all(color: Colors.white, width: 2),
                  //     ),
                  //     child: Text(
                  //       "${translator.getString("login.careline")} 123456789",
                  //       style: const TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w400,
                  //         fontFamily: "Gilroy",
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text(
                  //       "${translator.getString("login.newUser")} ",
                  //       style: const TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.white,
                  //         fontFamily: "Gilroy",
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.of(context)
                  //             .pushNamed(RegisterScreen.routName);
                  //       },
                  //       child: Container(
                  //         padding: const EdgeInsets.only(bottom: 3),
                  //         decoration: const BoxDecoration(
                  //           border: Border(
                  //             bottom: BorderSide(color: Colors.white, width: 3),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           translator.getString("login.register"),
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             color: MyColor.secondaryColor,
                  //             fontFamily: "Gilroy",
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const Expanded(child: SizedBox()),
                  // const Center(
                  //   child: Text(
                  //     "JOMZTECH",
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.white,
                  //       fontStyle: FontStyle.italic,
                  //       fontFamily: "Gilroy",
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  final Function(String mobile) onPressed;

  const ForgotPassword(this.onPressed);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final translator = TranslatorGenerator.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                "assets/images/forgotPassword.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            translator.getString("Forgot.verifyMobile"),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: InputField(
              hint: translator.getString("Forgot.verifyMobileHint"),
              color: Colors.white,
              errorTextColor: Colors.red,
              icon: Icons.mail,
              type: TextInputType.emailAddress,
              controller: emailController,
              borderColor: MyColor.primaryColor,
              validator: MultiValidator([
                RequiredValidator(
                  errorText: translator.getString("Forgot.verifyMobileEmpty"),
                ),
                EmailValidator(
                  errorText: translator.getString("Forgot.verifyMobileError"),
                )
              ]),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
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
              translator.getString("Forgot.textButton"),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                widget.onPressed(emailController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
