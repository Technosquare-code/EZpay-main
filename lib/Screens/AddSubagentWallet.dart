import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddSubagentWallet extends StatefulWidget {
  @override
  State<AddSubagentWallet> createState() => _AddSubagentWalletState();
}

class _AddSubagentWalletState extends State<AddSubagentWallet> {
  final translator = TranslatorGenerator.instance;
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
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
                "assets/images/sendMoney.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: InputField(
              hint: translator.getString("SubWallet.amountHint"),
              color: Colors.white,
              icon: Icons.attach_money,
              errorTextColor: Colors.red,
              type: TextInputType.emailAddress,
              controller: amountController,
              borderColor: MyColor.primaryColor,
              validator: RequiredValidator(
                errorText:
                    "* ${translator.getString("SubWallet.amountEmpty")}!",
              ),
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
              translator.getString("SubWallet.textButton"),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop(amountController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
